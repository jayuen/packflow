require 'spec_helper'

describe WorkflowDriver do
  describe "#find_matching_workflow" do
    let(:q1) {Question.new}
    let(:qa1) { WorkflowDriver::QuestionAndAnswer.new(q1, 'Y') }
    let!(:workflow) {Workflow.new}
    let!(:workflow_driver) do
      driver = WorkflowDriver.new(question: q1, answer: 'Y', workflow: workflow)
      workflow.drivers << driver
    end

    it "matches a workflow" do
      matches = WorkflowDriver.find_matching_workflows [qa1], [workflow]

      expect(matches.size).to eq(1)
      expect(matches.first).to eq(workflow)
    end

    it "does not match a workflow because answer does not match" do
      qa1.answer = 'not matching answer'

      matches = WorkflowDriver.find_matching_workflows [qa1], [workflow]

      expect(matches.size).to eq(0)
    end

    it "does not match a workflow because question does not match" do
      another_question = Question.new
      qa1.question = another_question

      matches = WorkflowDriver.find_matching_workflows [qa1], [workflow]

      expect(matches.size).to eq(0)
    end

    it "matches a workflow when all drivers are satisfied" do
    end

    it "does not match a workflow if one of the drivers are not specified" do
    end
  end
end
