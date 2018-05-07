require "../../spec_helper"
require "../../../src/actions/versions/create_version.cr"

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

describe Versions::CreateVersion do
  describe "#create" do
    it "when creating with invalid product_id must raise BadRequestException" do
        expect_raises(BadRequestException) do
          version = Versions::CreateVersion.new({"product_id" => "", "image" => "00.XXXXXXX"}).create
        end
    end

    it "when creating with invalid name must raise BadRequestException" do
        expect_raises(BadRequestException) do
          version = Versions::CreateVersion.new({"product_id" => create_product.id.to_s, "image" => ""}).create
        end
    end

    it "when creating with missing fields must raise BadRequestException" do
        expect_raises(BadRequestException) do
          version = Versions::CreateVersion.new(Hash(String, String).new).create
        end
    end

    it "when creating with invalid inexistent product_id must raise NotFoundException" do
        expect_raises(NotFoundException) do
          version = Versions::CreateVersion.new({"product_id" => "0", "image" => "00.XXXXXXX"}).create
        end
    end

    it "when creating with correct params must return successful result" do
      version = Versions::CreateVersion.new(version_hash).create
      version.id.should_not be_nil
    end
  end
end
