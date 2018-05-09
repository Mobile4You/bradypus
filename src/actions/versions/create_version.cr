require "../action_exception"

module Versions
  class CreateVersion

    def initialize(@create_version : Hash(String, String))
    end

    def create
      validate!

      if product = Product.find @create_version["product_id"]
        version = Version.new
        version.product = product
        version.image = @create_version["image"]

        unless version.save
          raise GenericException.new "Generic Error"
        end

        version
      else
        raise NotFoundException.new "Product ID #{ @create_version["product_id"] } Not Found"
      end
    end

    private def validate!
      if @create_version.fetch("image", "").blank?
        raise BadRequestException.new "Field image is not valid"
      end

      if @create_version.fetch("product_id", "").blank?
        raise BadRequestException.new "Field product_id is not valid"
      end
    end
  end
end
