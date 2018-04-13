class ActionResult
    getter errors : Array(String)

    def initialize(success : Bool)
        @errors = [] of String
        @errors << "Generic Error" unless success
    end

    def initialize(@errors : Array(String))
    end

    def success
        @errors.size == 0
    end
end