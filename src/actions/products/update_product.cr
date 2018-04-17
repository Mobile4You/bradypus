require "../action_result"

module Products
    class UpdateProduct
        # property errors = [] of String
        @result = ActionResult.new

        def initialize(@id : Int64?, @update_product : Hash(String, String))
        end

        def update 
            product = Product.find(@id)
            if product.nil?
                @result.add_error("Product not found")
                # return ActionResult.new(@errors)
                return @result
            end

            unless valid?
                # return ActionResult.new(@errors)
                return @result
            end

            product.set_attributes @update_product
        
            unless product.save
                @result.add_error "Generic Error"
            end

            @result
            # ActionResult.new product.save
        end

        private def valid?
            @result.add_error "Field name is not valid" if @update_product.fetch("name", "").blank?
            @result.success?
            # @errors << "Field name is not valid" if @update_product.fetch("name", "").blank?
            # @errors.empty?
        end
    end
end