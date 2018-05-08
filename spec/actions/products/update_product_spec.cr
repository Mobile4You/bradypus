require "../../spec_helper"
require "../../../src/actions/products/update_product.cr"

describe Products::UpdateProduct do
  describe "#update" do
    it "when updating with absent id must raise NotFoundException" do
      expect_raises(NotFoundException) do
        Products::UpdateProduct.new(1_i64, {"name" => "Another name"}).update
      end
    end

    it "when updating with invalid new name must raise BadRequestException" do
      product = create_product

      expect_raises(BadRequestException) do
        Products::UpdateProduct.new(product.id, {"name" => ""}).update
      end
    end

    it "when updating with missing field must raise BadRequestException" do
      product = create_product

      expect_raises(BadRequestException) do
        Products::UpdateProduct.new(product.id, Hash(String, String).new).update
      end
    end

    it "when update with correct params must return successful result" do
      product = create_product
      Products::UpdateProduct.new(product.id, {"name" => "Another name"}).update

      Product.find(product.id).try( &.name.should eq("Another name") )
    end
  end
end
