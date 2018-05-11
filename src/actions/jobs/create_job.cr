require "../action_exception"

module Jobs
  class CreateJob

    def initialize(@create_job : Hash(String, String))
    end

    def create
      validate!

      job = Job.new
      job.set_attributes @create_job
      
      unless job.save
        raise GenericException.new "Generic Error"
      end

      job
    end

    private def validate!
      if @create_job.fetch("name", "").blank?
        raise BadRequestException.new "Field name is not valid"
      end
    end
  end
end
