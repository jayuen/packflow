require 'spec_helper'

describe WorkflowDriver do
  describe "#find_matching_workflow" do
    let(:question1) {Question.new}
    let(:answer) { Answer.new(question1, 'Y') }
    let!(:workflow) {Workflow.new}
    let!(:workflow_driver) do
      driver = WorkflowDriver.new(question: question1, answer: 'Y', workflow: workflow)
      workflow.drivers << driver
    end

    it "matches a workflow" do
      matches = WorkflowDriver.find_matching_workflows [answer], [workflow]

      expect(matches.size).to eq(1)
      expect(matches.first).to eq(workflow)
    end

    it "does not match a workflow because answer does not match" do
      answer.value = 'not matching answer'

      matches = WorkflowDriver.find_matching_workflows [answer], [workflow]

      expect(matches.size).to eq(0)
    end

    it "does not match a workflow because question does not match" do
      another_question = Question.new
      answer.question = another_question

      matches = WorkflowDriver.find_matching_workflows [answer], [workflow]

      expect(matches.size).to eq(0)
    end

    it "matches a workflow when all drivers are satisfied" do
      another_question = Question.new 
      another_driver = WorkflowDriver.new question: another_question, answer: 'Y'
      workflow.drivers << another_driver
      another_answer = Answer.new another_question, 'Y'

      matches = WorkflowDriver.find_matching_workflows [answer, another_answer], [workflow]

      expect(matches.size).to eq(1)
    end

    it "does not match a workflow if one of the drivers are not satisfied" do
      another_question = Question.new 
      another_driver = WorkflowDriver.new question: another_question, answer: 'Y'
      workflow.drivers << another_driver
      bad_answer = Answer.new another_question, 'N'

      matches = WorkflowDriver.find_matching_workflows [answer, bad_answer], [workflow]

      expect(matches.size).to eq(0)
    end

    it "matches multiple workflows" do
      another_question = Question.new 
      another_driver = WorkflowDriver.new question: another_question, answer: 'Y'
      another_workflow = Workflow.new
      another_workflow.drivers << another_driver
      another_answer = Answer.new another_question, 'Y'

      matches = WorkflowDriver.find_matching_workflows [answer, another_answer], [another_workflow, workflow]

      expect(matches.size).to eq(2)
    end
  end
end
