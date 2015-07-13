class WelcomeController < ApplicationController
  def index
    @categories = Services.categories
  end
end
