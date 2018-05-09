require "../action_exception"

module Products
  class UpdateProduct
    
    def initialize(@id : Int64?, @update_product : Hash(String, String))
    end

    def update
      validate!

      product = Product.find(@id)
      if product.nil?
        raise NotFoundException.new "Product ID #{ @id } Not Found"
      end

      product.set_attributes @update_product

      unless product.save
        raise GenericException.new "Generic Error"
      end

      product
    end

    private def validate!
      if @update_product.fetch("name", "").blank?
        raise BadRequestException.new "Field name is not valid"
      end
    end
  end
end
