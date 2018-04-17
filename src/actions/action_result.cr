class ActionResult
    getter errors = [] of String

    def add_error(error)
        @errors << error
    end

    def success?
        @errors.size == 0
    end
end