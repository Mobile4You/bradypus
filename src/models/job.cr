class Job < Granite::ORM::Base
  adapter pg
  table_name jobs

  belongs_to :product

  # id : Int64 primary key is created for you
  field name : String
  field datacenters : String
  field job_type : String
  timestamps
end
