require "../action_exception"

module Jobs
  class UpdateJob
    
    def initialize(@id : Int64?, @update_job : Hash(String, String))
    end

    def update
      validate!

      job = Job.find(@id)
      if job.nil?
        raise NotFoundException.new "Job ID #{ @id } Not Found"
      end

      job.set_attributes @update_job

      unless job.save
        raise GenericException.new "Generic Error"
      end

      job
    end

    private def validate!
      if @update_job.fetch("name", "").blank?
        raise BadRequestException.new "Field name is not valid"
      end
    end
  end
end
