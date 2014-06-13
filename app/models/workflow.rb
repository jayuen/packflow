class Workflow < ActiveRecord::Base
  validates :code, uniqueness: true
  has_many :drivers, class_name: "WorkflowDriver"
  has_many :questions, through: :drivers
end
