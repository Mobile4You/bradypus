class DockerHubAuthentication < Granite::ORM::Base
  adapter pg
  table_name docker_hub_authentications


  # id : Int64 primary key is created for you
  field username : String
  field password : String
  timestamps
end
