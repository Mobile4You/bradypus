require "../action_exception"

module Products
  class CreateProduct

    def initialize(@create_product : Hash(String, String))
    end

    def create
      validate!

      product = Product.new
      product.set_attributes @create_product
      
      unless product.save
        raise GenericException.new "Generic Error"
      end

      product
    end

    private def validate!
      if @create_product.fetch("name", "").blank?
        raise BadRequestException.new "Field name is not valid"
      end
    end
  end
end
