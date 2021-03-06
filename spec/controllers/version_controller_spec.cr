require "../../spec_helper"

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
      Product.clear

      version = create_version
      response = subject.get "/products/#{version.product.id}/versions"

      response.status_code.should eq(200)
      response.body.should contain(version.image.to_s)
    end
  end

  describe "VersionController#create" do
    it "creates a version" do
      Version.clear
      Product.clear

      response = subject.post "/products/#{create_product.id}/versions", body: version_params

      version = Version.find_by :image, version_hash["image"]

      response.status_code.should eq(201)
      response.body.should contain(version.to_json)
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
