class TaskVariable < Granite::ORM::Base
  adapter pg
  table_name task_variables

  belongs_to :environment
  belongs_to :task

  # id : Int64 primary key is created for you
  field key : String
  field value : String
  timestamps
end
