module TestData
  extend self

  def build
    Workflow.destroy_all
    WorkflowDriver.destroy_all
    Question.destroy_all
    SettingDriver.destroy_all

    workflow_a = Workflow.create! code: 'A', description: 'Planned receiving'
    workflow_b = Workflow.create! code: 'B', description: 'Unplanned receiving'

    question_1 = Question.create! code: 'Q1', title: 'What colour do you like?'
    question_2 = Question.create! code: 'Q2', title: 'What is your favourite food?'

    WorkflowDriver.create! workflow: workflow_a, answer: 'Y', question: question_1 
    WorkflowDriver.create! workflow: workflow_a, answer: 'N', question: question_2 

    WorkflowDriver.create! workflow: workflow_b, answer: 'N', question: question_1 
    WorkflowDriver.create! workflow: workflow_b, answer: 'Y', question: question_2 

  end
end
