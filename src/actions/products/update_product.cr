require "../action_result"

module Products
  class UpdateProduct
    @result : ActionResult = ActionResult.new

    def initialize(@id : Int64?, @update_product : Hash(String, String))
    end

    def update
      product = Product.find(@id)
      if product.nil?
        @result.add_error("Product not found")
        return @result
      end

      unless valid?
        return @result
      end

      product.set_attributes @update_product

      unless product.save
        @result.add_error "Generic Error"
      end

      @result
    end

    private def valid?
      @result.add_error "Field name is not valid" if @update_product.fetch("name", "").blank?
      @result.success?
    end
  end
end
