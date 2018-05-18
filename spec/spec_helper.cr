ENV["AMBER_ENV"] ||= "test"

require "spec"
require "garnet_spec"
require "../config/*"

module Spec
  DRIVER = :chrome
  PATH   = "/usr/local/bin/chromedriver"

  # Not all server implementations will support every WebDriver feature.
  # Therefore, the client and server should use JSON objects with the properties
  # listed below when describing which features a session supports.
  capabilities = {
    browserName:              "chrome",
    version:                  "",
    platform:                 "ANY",
    javascriptEnabled:        true,
    takesScreenshot:          true,
    handlesAlerts:            true,
    databaseEnabled:          true,
    locationContextEnabled:   true,
    applicationCacheEnabled:  true,
    browserConnectionEnabled: true,
    cssSelectorsEnabled:      true,
    webStorageEnabled:        true,
    rotatable:                true,
    acceptSslCerts:           true,
    nativeEvents:             true,
    args:                     "--headless",
  }
end

def product_hash
  {"name" => "Fake"}
end

def create_product
  product = Product.new(product_hash)
  product.save
  product
end

def version_hash
  {
    "product_id" => create_product.id.to_s,
    "image" => "00.XXXXXXX"
  }
end

def create_version
  version = Version.new(version_hash)
  version.save
  version
end

def job_hash
  {
    "name" => "Fake",
    "job_type" => "lalazin",
    "datacenters" => "locahostl"
  }
end

def create_job
  job = Job.new(job_hash)
  job.save
  job
end
