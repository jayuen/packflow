class ConfigsController < ApplicationController
  def index
    @workflows = Workflow.all.to_json
    @questions = Question.all.to_json
    @workflow_drivers = WorkflowDriver.all.to_json
  end
end
