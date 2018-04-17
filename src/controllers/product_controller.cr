require "../actions/products/*"

class ProductController < ApplicationController
  getter errors = [] of String
  
  def index
    products = Product.all
    render("index.slang")
  end

  def show
    if product = Product.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def new
    product = Product.new
    render("new.slang")
  end

  def create
    result = Products::CreateProduct.new({"name" => params["name"]}).create
    if result.success?
      flash["success"] = "Created Product successfully."
      redirect_to "/products"
    else
      product = Product.new
      flash["danger"] = "Could not create Product!"
      @errors = result.errors
      render("new.slang")
    end
  end

  def edit
    if product = Product.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def update
    result = Products::UpdateProduct.new(params["id"].to_i64, {"name" => params["name"]}).update
    if result.success?
      flash["success"] = "Updated Product successfully."
      redirect_to "/products"
    else 
      if product = Product.find(params["id"])
        @errors = result.errors
        flash["danger"] = "Could not update Product!"
        render("edit.slang")
      end
    end
  end

  def destroy
    if product = Product.find params["id"]
      product.destroy
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
    end
    redirect_to "/products"
  end

  def product_params
    params.validation do
      required(:name) { |f| !f.blank? }
    end
  end
end
