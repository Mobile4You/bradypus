require "../actions/jobs/*"

class JobController < ApplicationController

  def index
    jobs = Job.all "order by name"
    render("index.slang")
  end

  def show
    if job = Job.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Job ID #{params["id"]} Not Found"
      redirect_to "/jobs"
    end
  end

  def new
    job = Job.new
    render("new.slang")
  end

  def create
    result = Jobs::CreateJob.new({"name" => params["name"]}).create
    flash["success"] = "Job has been created."
    redirect_to "/jobs"
  rescue ex
    job = Job.new
    flash["danger"] = "#{ex.message}"
    render("new.slang")
  end

  def edit
    if job = Job.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Job ID #{params["id"]} Not Found"
      redirect_to "/jobs"
    end
  end

  def update
    result = Jobs::UpdateJob.new(params["id"].to_i64, {"name" => params["name"]}).update
    flash["success"] = "Job has been updated."
    redirect_to "/jobs"
  rescue ex
    if job = Job.find(params["id"])
      flash["danger"] = "#{ex.message}"
      render("edit.slang")
    end
  end

  def destroy
    if job = Job.find params["id"]
      job.destroy
      flash["warning"] = "Job ID #{params["id"]} has been destroyed"
    else
      flash["warning"] = "Job ID #{params["id"]} Not Found"
    end
    redirect_to "/jobs"
  end

  def job_params
    params.validation do
      required(:name) { |f| !f.blank? }
    end
  end
end
