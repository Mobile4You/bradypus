require "../../spec_helper"
require "../../../src/actions/products/create_product.cr"

def product_hash
  {"name" => "Fake"}
end

describe Products::UpdateProduct do
  describe "#create" do
    it "when create with invalid name must return invalid result with errors" do
        action = Products::CreateProduct.new({"name" => ""}).create

        action.succsuccess?ess.should be_false
        action.errors.size.should eq(1)
        action.errors[0].should eq("Field name is not valid")
    end

    it "when create with missing fields must return invalid result with errors" do
        action = Products::CreateProduct.new(Hash(String, String).new).create

        action.success?.should be_false
        action.errors.size.should eq(1)
        action.errors[0].should eq("Field name is not valid")
    end

    it "when create with correct params must return successful result" do
        action = Products::CreateProduct.new(product_hash).create

        action.success?.should be_true
        action.errors.size.should eq(0)
    end
  end
end
