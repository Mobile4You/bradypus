require "../../spec_helper"
require "../../../src/actions/products/update_product.cr"

def product_hash
  {"name" => "Fake"}
end

def create_product
  model = Product.new(product_hash)
  model.save
  model
end

describe Products::UpdateProduct do
  describe "#update" do
    it "when updating with absent id must raise NotFoundException" do
      Product.clear

      expect_raises(NotFoundException) do
        product = Products::UpdateProduct.new(1_i64, {"name" => "Another name"}).update
      end
    end

    it "when updating with invalid new name must raise BadRequestException" do
      Product.clear
      model = create_product

      expect_raises(BadRequestException) do
        product = Products::UpdateProduct.new(model.id, {"name" => ""}).update
      end
    end

    it "when updating with missing field must raise BadRequestException" do
      Product.clear
      model = create_product

      expect_raises(BadRequestException) do
        product = Products::UpdateProduct.new(model.id, Hash(String, String).new).update
      end
    end

    it "when update with correct params must return successful result" do
      Product.clear
      model = create_product
      product = Products::UpdateProduct.new(model.id, {"name" => "Another name"}).update

      Product.find(model.id).try( &.name.should eq("Another name") )
    end
  end
end
