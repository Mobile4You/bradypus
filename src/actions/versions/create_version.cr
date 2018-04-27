require "../action_result"

module Versions
  class CreateVersion
    @result : ActionResult = ActionResult.new

    def initialize(@create_version : Hash(String, String))
    end

    def create
      unless valid?
        return @result
      end

      if product = Product.find @create_version["id"]
        version = Version.new
        version.product = product
        version.image @create_version["image"]
      else
        @result.add_error("Product with ID #{ @create_version["id"] } Not Found")
      end

      unless version.save
        @result.add_error("Generic Error")
      end

      @result
    end

    private def valid?
      @result.add_error "Field image is not valid" if @create_version.fetch("image", "").blank?
      @result.success?
    end
  end
end
