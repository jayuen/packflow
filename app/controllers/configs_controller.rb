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
end
