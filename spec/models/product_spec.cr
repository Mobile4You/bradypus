require "./spec_helper"
require "../../src/models/product.cr"

describe Product do
  Spec.before_each do
    Product.clear
  end
end
