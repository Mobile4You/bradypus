require "../../spec_helper"
require "../../../src/actions/jobs/create_job.cr"

describe Jobs::CreateJob do
  describe "#create" do
    it "when creating with invalid name must raise BadRequestException" do
        expect_raises(BadRequestException) do
          Jobs::CreateJob.new({"name" => ""}).create
        end
    end

    it "when creating with missing fields must must raise BadRequestException" do
        expect_raises(BadRequestException) do
          Jobs::CreateJob.new(Hash(String, String).new).create
        end
    end

    it "when creating with correct params must return successful result" do
      jobs = Jobs::CreateJob.new(job_hash).create
      jobs.id.should_not be_nil
    end
  end
end
