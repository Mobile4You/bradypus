require "../../spec_helper"
require "../../../src/actions/products/create_product.cr"

describe Products::CreateProduct do
  describe "#create" do
    it "when creating with invalid name must raise BadRequestException" do
        expect_raises(BadRequestException) do
          Products::CreateProduct.new({"name" => ""}).create
        end
    end

    it "when creating with missing fields must must raise BadRequestException" do
        expect_raises(BadRequestException) do
          Products::CreateProduct.new(Hash(String, String).new).create
        end
    end

    it "when creating with correct params must return successful result" do
      product = Products::CreateProduct.new(product_hash).create
      product.id.should_not be_nil
    end
  end
end
