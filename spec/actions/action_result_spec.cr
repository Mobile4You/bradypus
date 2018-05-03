require "../../spec_helper"
require "../../src/actions/action_result.cr"

describe ActionResult do
  describe "#add_error" do
    it "when add_error must add element to array" do 
      result = ActionResult.new
      result.add_error "Anything"

      result.errors.size.should eq(1)
      result.errors[0].should eq("Anything")
    end
  end

  describe "#success?" do
    it "when success? with no errors must return true" do 
      result = ActionResult.new

      result.success?.should be_true
    end

    it "when success? with any error must return false" do 
      result = ActionResult.new
      result.add_error "Anything"

      result.success?.should be_false
    end
  end
end
