module Products
    class CreateProduct
        # @errors = [] of String
        @result : ActionResult = ActionResult.new

        def initialize(@create_product : Hash(String, String))
        end

        def create
            unless valid?
                return @result
            end

            product = Product.new
            product.set_attributes @create_product
            
            unless product.save
                @result.add_error("Generic Error")
            end
            
            @result
        end

        private def valid?
            @result.add_error "Field name is not valid" if @create_product.fetch("name", "").blank?
            @result.success?
        end
    end
end