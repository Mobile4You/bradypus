class ActionResult
    getter errors = [] of String

    def add_error(error)
        @errors << error
    end

    def success?
        @errors.empty?
    end
end