require "../actions/versions/*"

class VersionController < ApplicationController
  
  def index
    if product = Product.find params["id"]
      id = params["id"]
      versions = product.versions
      render("index.slang")
    else
      flash["warning"] = "Product with ID #{ params["id"] } Not Found"
      redirect_to "/products"
    end
  end

  def create
    version = Versions::CreateVersion.new({"image" => params["image"], "id" => params["id"]}).create
    set_response version.to_json, 201, Content::TYPE[:json]
  rescue ex : BadRequestException
    set_response ex.to_json, 400, Content::TYPE[:json]
  rescue ex : NotFoundException
    set_response ex.to_json, 404, Content::TYPE[:json]
  rescue ex
    message = { "error" => ex.message }.to_json
    set_response message, 500, Content::TYPE[:json]
  end
end
