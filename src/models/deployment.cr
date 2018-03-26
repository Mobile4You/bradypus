class Deployment < Granite::ORM::Base
  adapter pg
  table_name deployments

  belongs_to :group_task
  belongs_to :version

  # id : Int64 primary key is created for you
  timestamps
end
