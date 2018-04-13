require "../action_result"

module Products
    class UpdateProduct
        property errors = [] of String

        def initialize(@id : Int64?, @update_product : Hash(String, String))
        end

        def update 
            product = Product.find(@id)
            if product.nil?
                @errors << "Product not found"
                return ActionResult.new(@errors)
            end

            unless valid?
                return ActionResult.new(@errors)
            end

            product.set_attributes @update_product
            
            ActionResult.new product.save
        end

        private def valid?
            @errors << "Field name is not valid" if @update_product.fetch("name", "").blank?
            @errors.empty?
        end
    end
end