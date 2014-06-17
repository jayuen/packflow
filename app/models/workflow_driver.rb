class WorkflowDriver < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :question

  def self.workflows_for answers
    workflows = Workflow.all
    find_matching_workflows answers, workflows
  end

  def self.find_matching_workflows answers, workflows
    matches = []
    workflows.each do |workflow|
      match = true
      workflow.drivers.each do |driver|
        question = driver.question
        answer = answers.find {|a| a.question == question}
        if answer.present?
          match = false if answer.value != driver.answer
        else
          match = false
        end
      end

      matches << workflow if match
    end

    matches
  end
end
