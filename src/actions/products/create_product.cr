module Products
    class CreateProduct
        @errors = [] of String

        def initialize(@create_product : Hash(String, String))
        end

        def create
            unless valid?
                return ActionResult.new(@errors)
            end

            product = Product.new
            product.set_attributes @create_product
            
            ActionResult.new product.save
        end

        private def valid?
            @errors << "Field name is not valid" if @create_product.fetch("name", "").blank?
            @errors.empty?
        end
    end
end