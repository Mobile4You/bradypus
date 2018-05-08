require "../../spec_helper"

def product_params
  params = [] of String
  params << "name=#{product_hash["name"]}"
  params.join("&")
end

def invalid_product_params
  params = [] of String
  params << "name="
  params.join("&")
end

class ProductControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe ProductControllerTest do
  subject = ProductControllerTest.new

  it "renders product index template" do
    response = subject.get "/products"

    response.status_code.should eq(200)
    response.body.should contain("Products")
  end

  it "renders product show template" do
    product = create_product
    location = "/products/#{product.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Product")
  end

  it "when render product by id with absent customer must contains product not found" do
    location = "/products/1"

    response = subject.get location

    response.status_code.should eq(302)
    response.headers["Location"].should eq("/products")
  end

  it "renders product new template" do
    location = "/products/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Product")
  end

  it "renders product edit template" do
    product = create_product
    location = "/products/#{product.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Product")
  end

  it "when render edit product with absent customer must contains product not found" do
    location = "/products/1/edit"

    response = subject.get location

    response.status_code.should eq(302)
    response.headers["Location"].should eq("/products")
  end

  it "creates a product" do
    response = subject.post "/products", body: product_params

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "when create a product with invalid params must not create" do
    response = subject.post "/products", body: invalid_product_params

    response.status_code.should eq(200)
    response.body.should contain("Field name is not valid")
  end

  it "updates a product" do
    product = create_product
    response = subject.patch "/products/#{product.id}", body: product_params

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "when update a product with invalid params must not update" do
    product = create_product
    response = subject.patch "/products/#{product.id}", body: invalid_product_params

    response.status_code.should eq(200)
    response.body.should contain("Field name is not valid")
  end

  it "deletes a product" do
    product = create_product
    response = subject.delete "/products/#{product.id}"

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
