require "./spec_helper"

def product_hash
  {"name" => "Fake"}
end

def create_product
  model = Product.new(product_hash)
  model.save
  model
end

def version_hash
  {
    "product_id" => create_product.id.to_s,
    "image" => "00.XXXXXXX"
  }
end

def version_params
  params = [] of String
  params << "image=#{version_hash["image"]}"
  params << "product_id=#{version_hash["product_id"]}"
  params.join("&")
end

def invalid_version_params
  params = [] of String
  params << "image="
  params.join("&")
end

def create_version
  version = Version.new(version_hash)
  version.save
  version
end


class VersionControllerTest < GarnetSpec::Controller::Test
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

describe VersionController do
  subject = VersionControllerTest.new

  describe "VersionController#index" do
    it "renders the view" do
      Version.clear
      version = create_version
      response = subject.get "/products/#{version.product.id}/versions"

      response.status_code.should eq(200)
      response.body.should contain(version.image.to_s)
    end
  end

  describe "VersionController#create" do
    it "creates a version" do
      response = subject.post "/products/#{create_product.id}/versions", body: version_params
      response.status_code.should eq(201)
    end

    it "when creating a version without image must not create" do
      response = subject.post "/products/#{create_product.id}/versions", body: invalid_version_params
      response.status_code.should eq(400)
    end
    
    it "when creating a version with inexistent product_id image must not create" do
      response = subject.post "/products/0/versions", body: version_params
      response.status_code.should eq(404)
    end
  end
end
