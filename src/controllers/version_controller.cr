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
    # render("create.slang")
    v = Version.new
    v.id = 1_i64
    respond_with { json v.to_json }
  end
end
