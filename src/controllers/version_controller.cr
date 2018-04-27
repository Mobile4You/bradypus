class VersionController < ApplicationController
  def index
    render("index.slang")
  end

  def create
    v = Version.new
    v.id = 1_64
    respond_with { json v.to_json }
  end
end
