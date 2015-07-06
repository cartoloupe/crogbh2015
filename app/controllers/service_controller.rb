class ServiceController < ApplicationController
  def category
    raise ActionController::RoutingError.new('Not Found') if params['category'].nil?
    @category      = params['category'].to_sym
    @category_name = params['category']
      .split('-')
      .map(&:capitalize)
      .join(' ')
    render 'category'
  end
end
