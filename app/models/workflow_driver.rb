class WorkflowDriver < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :question

  QuestionAndAnswer = Struct.new(:question, :answer) 

  def self.workflows_for question_data
    question_and_answers = question_data.map do |question_code, answer|
      question = Question.find_by_code(question_code)
      QuestionAndAnswer.new(question, answer)
    end

    workflows = Workflow.all
    find_matching_workflows question_and_answers, workflows
  end

  def self.find_matching_workflows questions_and_answers, workflows
    matches = []
    match = true
    workflows.each do |workflow|
      workflow.drivers.each do |driver|
        questions_and_answers.each do |qa|
          if driver.answer != qa.answer || driver.question != qa.question
            match = false
          end
        end
      end

      matches << workflow if match
    end

    matches
  end
end
