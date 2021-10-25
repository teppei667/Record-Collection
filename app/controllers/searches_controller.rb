class SearchesController < ApplicationController

  before_action :authenticate_end_user!

  def search
    @content = params["content"]
  end
end
