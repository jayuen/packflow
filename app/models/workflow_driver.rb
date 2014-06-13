class WorkflowDriver < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :question
end
