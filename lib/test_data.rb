module TestData
  extend self

  def build
    Workflow.destroy_all
    WorkflowDriver.destroy_all
    Question.destroy_all
    SettingDriver.destroy_all

    workflow_1 = Workflow.create! code: 'W1', description: 'Mobile + Planned Receipt'
    workflow_2 = Workflow.create! code: 'W2', description: 'Mobile + No Planned Receipt'
    workflow_3 = Workflow.create! code: 'W3', description: 'No Mobile + No Planned Receipt'
    workflow_4 = Workflow.create! code: 'W4', description: 'No Mobile + Planned Receipt'

    question_1 = Question.create! code: '1', title: 'Are you able to use mobile devices on the receiving floor?'
    question_2 = Question.create! code: '2', title: 'Do you get ASNs for what is expected on a truck?'
    question_3 = Question.create! code: '3', title: 'Do you record time arrived?'

    WorkflowDriver.create! workflow: workflow_1, answer: 'Y', question: question_1 
    WorkflowDriver.create! workflow: workflow_1, answer: 'Y', question: question_2 

    WorkflowDriver.create! workflow: workflow_2, answer: 'Y', question: question_1 
    WorkflowDriver.create! workflow: workflow_2, answer: 'N', question: question_2 

    WorkflowDriver.create! workflow: workflow_3, answer: 'N', question: question_1 
    WorkflowDriver.create! workflow: workflow_3, answer: 'N', question: question_2 

    WorkflowDriver.create! workflow: workflow_4, answer: 'N', question: question_1 
    WorkflowDriver.create! workflow: workflow_4, answer: 'Y', question: question_2 
  end
end
