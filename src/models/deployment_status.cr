class DeploymentStatus < Granite::ORM::Base
  adapter pg
  table_name deployment_statuss

  belongs_to :deployment
  belongs_to :environment

  # id : Int64 primary key is created for you
  field status : String
  timestamps
end
