require "./spec_helper"
require "../../src/models/docker_hub_authentication.cr"

describe DockerHubAuthentication do
  Spec.before_each do
    DockerHubAuthentication.clear
  end
end
