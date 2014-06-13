class ConfigsController < ApplicationController
  def index
    @workflows = Workflow.all.to_json
    @questions = Question.all.to_json
    @workflow_drivers = WorkflowDriver.all.to_json
  end

  def add_new_workflow
    new_workflow = Workflow.create! params.permit(:code, :description)
    render json: new_workflow 
  end

  def add_new_question
    new_question = Question.create! params.permit(:code, :title)
    render json: new_question 
  end
end
