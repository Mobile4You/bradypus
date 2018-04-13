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
    it "when update with absent id must return not found result" do
      Product.clear
      action = Products::UpdateProduct.new(1_i64, {"name" => "Another name"}).update
      
      action.success.should be_false
      action.errors.size.should eq(1)
      action.errors[0].should eq("Product not found")
    end

    it "when update with invalid new name must return invalid result with errors" do 
      Product.clear
      model = create_product
      action = Products::UpdateProduct.new(model.id, {"name" => ""}).update

      action.success.should be_false
      action.errors.size.should eq(1)
      action.errors[0].should eq("Field name is not valid")
    end

    it "when update with missing field must return invalid result with errors" do 
      Product.clear
      model = create_product
      action = Products::UpdateProduct.new(model.id, Hash(String, String).new).update

      action.success.should be_false
      action.errors.size.should eq(1)
      action.errors[0].should eq("Field name is not valid")
    end

    it "when update with correct params must return successful result" do 
      Product.clear
      model = create_product
      action = Products::UpdateProduct.new(model.id, {"name" => "Another name"}).update

      action.success.should be_true
      action.errors.size.should eq(0)
      Product.find(model.id).try( &.name.should eq("Another name") )
    end
  end
end
