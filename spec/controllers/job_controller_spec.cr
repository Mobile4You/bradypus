require "../../spec_helper"

def job_params
  params = [] of String
  params << "name=#{job_hash["name"]}"
  params << "datacenters=#{job_hash["datacenters"]}"
  params << "job_type=#{job_hash["job_type"]}"  
  params.join("&")
end

def invalid_job_params
  params = [] of String
  params << "name="
  params << "datacenters="
  params << "job_type="  
  params.join("&")
end

class JobControllerTest < GarnetSpec::Controller::Test
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

describe JobControllerTest do
  subject = JobControllerTest.new
  product = create_product

  it "renders job index template" do
    Job.all.each { |job| job.destroy }
    response = subject.get "/products/#{product.id}/jobs"

    response.status_code.should eq(200)
    response.body.should contain("Jobs")
  end

  it "renders job show template" do
    Job.all.each { |job| job.destroy }
    job = create_job
    location = "/products/#{product.id}/jobs/#{job.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Job")
  end

  it "when render job by id with absent customer must contains job not found" do
    Job.all.each { |job| job.destroy }
    location = "/products/#{product.id}/jobs/1"

    response = subject.get location

    response.status_code.should eq(302)
    response.headers["Location"].should eq("/products/#{product.id}/jobs")
  end

  it "renders job new template" do
    Job.all.each { |job| job.destroy }
    location = "/products/#{product.id}/jobs/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Job")
  end

  it "renders job edit template" do
    Job.all.each { |job| job.destroy }
    job = create_job
    location = "/products/#{product.id}/jobs/#{job.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Job")
  end

  it "when render edit job with absent customer must contains job not found" do
    Job.all.each { |job| job.destroy }
    location = "/products/#{product.id}/jobs/1/edit"

    response = subject.get location

    response.status_code.should eq(302)
    response.headers["Location"].should eq("/products/#{product.id}/jobs")
  end

  it "creates a job" do
    Job.all.each { |job| job.destroy }
    response = subject.post "/products/#{product.id}/jobs", body: job_params

    puts "HEADERS: #{response.headers}"
    response.headers["Location"].should eq "/products/#{product.id}/jobs"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "when create a job with invalid params must not create" do
    Job.all.each { |job| job.destroy }
    response = subject.post "/products/#{product.id}/jobs", body: invalid_job_params

    response.status_code.should eq(200)
    response.body.should contain("Field name is not valid")
  end

  it "updates a job" do
    Job.all.each { |job| job.destroy }
    job = create_job
    response = subject.patch "/products/#{product.id}/jobs/#{job.id}", body: job_params

    response.headers["Location"].should eq "/products/#{product.id}/jobs"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "when update a job with invalid params must not update" do
    Job.all.each { |job| job.destroy }
    job = create_job
    response = subject.patch "/products/#{product.id}/jobs/#{job.id}", body: invalid_job_params

    response.status_code.should eq(200)
    response.body.should contain("Field name is not valid")
  end

  it "deletes a job" do
    Job.all.each { |job| job.destroy }
    job = create_job
    response = subject.delete "/products/#{product.id}/jobs/#{job.id}"

    response.headers["Location"].should eq "/products/#{product.id}/jobs"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
