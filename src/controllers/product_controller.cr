class ProductController < ApplicationController
  getter errors = [] of Amber::Validators::Error
  
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
    if product_params.valid?
      product = Product.new(product_params.validate!)
      if product.save
        flash["success"] = "Created Product successfully."
        redirect_to "/products"
      else
        flash["danger"] = "Could not create Product!"
        render("new.slang")
      end
    else
      product = Product.new
      @errors = product_params.errors
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
    if product = Product.find(params["id"])
      if product_params.valid?
        product.set_attributes product_params.validate!
        if product.save
          flash["success"] = "Updated Product successfully."
          redirect_to "/products"
        else
          flash["danger"] = "Could not update Product!"
          render("edit.slang")
        end
      else
        @errors = product_params.errors
        flash["danger"] = "Could not update Product!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
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
