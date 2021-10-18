class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @content = params["content"]
  end
end
