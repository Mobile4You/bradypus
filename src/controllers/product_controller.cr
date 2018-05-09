require "../actions/products/*"

class ProductController < ApplicationController

  def index
    products = Product.all "order by name"
    render("index.slang")
  end

  def show
    if product = Product.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Product ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def new
    product = Product.new
    render("new.slang")
  end

  def create
    result = Products::CreateProduct.new({"name" => params["name"]}).create
    flash["success"] = "Product has been created."
    redirect_to "/products"
  rescue ex
    product = Product.new
    flash["danger"] = "#{ex.message}"
    render("new.slang")
  end

  def edit
    if product = Product.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Product ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def update
    result = Products::UpdateProduct.new(params["id"].to_i64, {"name" => params["name"]}).update
    flash["success"] = "Product has been updated."
    redirect_to "/products"
  rescue ex
    if product = Product.find(params["id"])
      flash["danger"] = "#{ex.message}"
      render("edit.slang")
    end
  end

  def destroy
    if product = Product.find params["id"]
      product.destroy
      flash["warning"] = "Product ID #{params["id"]} has been destroyed"
    else
      flash["warning"] = "Product ID #{params["id"]} Not Found"
    end
    redirect_to "/products"
  end

  def product_params
    params.validation do
      required(:name) { |f| !f.blank? }
    end
  end
end
