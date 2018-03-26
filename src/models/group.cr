class Group < Granite::ORM::Base
  adapter pg
  table_name groups

  belongs_to :job

  # id : Int64 primary key is created for you
  field name : String
  field ephemeral_disk_size : String
  field count : Int32
  field update_canary : Int32
  field update_max_parallel : Int32
  field update_health_check : String
  field update_min_healthy_time : String
  field update_healthy_deadline : String
  field update_auto_revert : Bool
  timestamps
end
