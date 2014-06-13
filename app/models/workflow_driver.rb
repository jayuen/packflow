class WorkflowDriver < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :question

  QuestionAndAnswer = Struct.new(:question, :answer) 

  def self.workflows_for question_data
    question_and_answers = question_data.map do |question_code, answer|
      question = Question.find_by_code(question_code)
      QuestionAndAnswer.new(question, answer)
    end

    p WorkflowDriver.group_by(:workflow_id)
  end
end
