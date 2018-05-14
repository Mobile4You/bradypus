require "../actions/jobs/*"

class JobController < ApplicationController

  def index
    if product = Product.find params["id"]
      product_id = params["id"]
      jobs = product.jobs
      render("index.slang")
    else
      flash["warning"] = "Product with ID #{ params["id"] } Not Found"
      redirect_to "/products"
    end
  end

  def show
    if job = Job.find params["jobId"]
      render("show.slang")
    else
      flash["warning"] = "Job ID #{params["id"]} Not Found"
      redirect_to "/products/#{params["id"]}/jobs"
    end
  end

  def new
    job = Job.new
    job.product_id = params["id"].to_i64
    render("new.slang") 
  end

  def create
    result = Jobs::CreateJob.new({
      "name" => params["name"],
      "datacenters" => params["datacenters"],
      "job_type" => params["job_type"],
      "product_id" => params["id"],
      }).create
    flash["success"] = "Job has been created."
    redirect_to "/products/#{params["id"]}/jobs"
  rescue ex
    job = Job.new
    flash["danger"] = "#{ex.message}"
    render("new.slang")
  end

  def edit
    if job = Job.find params["jobId"]
      render("edit.slang")
    else
      flash["warning"] = "Job ID #{params["id"]} Not Found"
      redirect_to "/products/#{params["id"]}/jobs"
    end
  end

  def update
    result = Jobs::UpdateJob.new(params["jobId"].to_i64, {
      "name" => params["name"],
      "datacenters" => params["datacenters"],
      "job_type" => params["job_type"],
    }).update
    flash["success"] = "Job has been updated."
    redirect_to "/products/#{params["id"]}/jobs"
  rescue ex
    if job = Job.find(params["jobId"])
      flash["danger"] = "#{ex.message}"
      render("edit.slang")
    end
  end

  def destroy
    if job = Job.find params["jobId"]
      job.destroy
      flash["warning"] = "Job ID #{params["jobId"]} has been destroyed"
    else
      flash["warning"] = "Job ID #{params["jobId"]} Not Found"
    end
    redirect_to "/products/#{params["id"]}/jobs"
  end

  def job_params
    params.validation do
      required(:name) { |f| !f.blank? }
    end
  end
end
