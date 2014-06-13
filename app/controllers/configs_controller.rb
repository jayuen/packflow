class ConfigsController < ApplicationController
  def index
    @workflows = Workflow.all.to_json
    @questions = Question.all.to_json
    @workflow_drivers = WorkflowDriver.all.to_json
    @setting_drivers = SettingDriver.all.to_json
  end

  def add_new_workflow
    new_workflow = Workflow.create! params.permit(:code, :description)
    render json: new_workflow 
  end

  def add_new_question
    new_question = Question.create! params.permit(:code, :title)
    render json: new_question 
  end

  def add_new_workflow_driver
    new_workflow_driver = WorkflowDriver.create! params.permit(:workflow_id, :question_id, :answer)
    render json: new_workflow_driver 
  end

  def add_new_setting_driver
    new_setting_driver = SettingDriver.create! params.permit(:setting, :setting_type, :question_id, :answer)
    render json: new_setting_driver 
  end
end
