require "./spec_helper"
require "../../src/models/deployment_status.cr"

describe DeploymentStatus do
  Spec.before_each do
    DeploymentStatus.clear
  end
end
