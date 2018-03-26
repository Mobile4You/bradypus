class Version < Granite::ORM::Base
  adapter pg
  table_name versions

  belongs_to :product

  # id : Int64 primary key is created for you
  field image : String
  timestamps
end
