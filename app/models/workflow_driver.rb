class WorkflowDriver < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :question

  def self.workflows_for answer_data
    answers = answer_data.map do |question_code, answer|
      question = Question.find_by_code(question_code)
      Answer.new(question, answer)
    end

    workflows = Workflow.all
    find_matching_workflows answers, workflows
  end

  def self.find_matching_workflows answers, workflows
    matches = []
    workflows.each do |workflow|
      match = true
      workflow.drivers.each do |driver|
        answers.each do |answer|
          if driver.question == answer.question
            if driver.answer != answer.value
              match = false
            end
          end
        end
      end

      matches << workflow if match
    end

    matches
  end
end
