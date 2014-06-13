class Workflow < ActiveRecord::Base
  validates :code, uniqueness: true
end
