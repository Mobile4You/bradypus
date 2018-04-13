require "../../spec_helper"
require "../../src/actions/action_result.cr"

describe ActionResult do
  describe "#initialize" do
    it "with empty array must assign the values and success be true" do
      errors = [] of String
      result = ActionResult.new(errors)
      result.success.should be_true
      result.errors.should eq([] of String)
    end

    it "with array with any error must assign errors and success be false" do
      errors = ["can t be blank"] of String
      result = ActionResult.new(errors)
      result.success.should be_false
      result.errors.size.should eq(1)
      result.errors[0].should eq("can t be blank")
    end
  end
end
