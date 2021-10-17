class SearchesController < ApplicationController
  def search
    @content = params["content"]
  end
end
