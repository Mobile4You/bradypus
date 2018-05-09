module JsonMessage
  def to_json
    { "error" => message }.to_json
  end
end

class GenericException < Exception
  include JsonMessage
end

class NotFoundException < Exception
  include JsonMessage
end

class BadRequestException < Exception
  include JsonMessage
end
