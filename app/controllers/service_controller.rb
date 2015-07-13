class ServiceController < ApplicationController
  def category
    raise ActionController::RoutingError.new('Not Found') if params['category'].nil?
    @category = Services[params['category'].to_sym]
    render 'category'
  end
end
