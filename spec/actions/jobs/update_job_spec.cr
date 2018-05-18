require "../../spec_helper"
require "../../../src/actions/jobs/update_job.cr"

describe Jobs::UpdateJob do
  describe "#update" do
    it "when updating with absent id must raise NotFoundException" do
      expect_raises(NotFoundException) do
        Jobs::UpdateJob.new(1_i64, {"name" => "Another name"}).update
      end
    end

    it "when updating with invalid new name must raise BadRequestException" do
      job = create_job

      expect_raises(BadRequestException) do
        Jobs::UpdateJob.new(job.id, {"name" => ""}).update
      end
    end

    it "when updating with missing field must raise BadRequestException" do
      job = create_job

      expect_raises(BadRequestException) do
        Jobs::UpdateJob.new(job.id, Hash(String, String).new).update
      end
    end

    it "when update with correct params must return successful result" do
      job = create_job
      Jobs::UpdateJob.new(job.id, {
        "name" => "Another name",
        "datacenters" => "datacenter2",
        "job_type" => "o-type",
        }).update

      Job.find(job.id).try( &.name.should eq("Another name") )
    end
  end
end
