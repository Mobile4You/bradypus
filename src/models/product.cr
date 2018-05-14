class Product < Granite::ORM::Base
  adapter pg
  table_name products

  has_many :versions
  has_many :jobs


  # id : Int64 primary key is created for you
  field name : String
  timestamps
end
