class GroupTask < Granite::ORM::Base
  adapter pg
  table_name group_tasks

  belongs_to :group
  belongs_to :task
  belongs_to :docker_hub_authentication

  # id : Int64 primary key is created for you
  timestamps
end
