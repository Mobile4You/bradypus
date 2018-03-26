class Environment < Granite::ORM::Base
  adapter pg
  table_name environments


  # id : Int64 primary key is created for you
  field name : String
  field host : String
  field strategy : String
  timestamps
end
