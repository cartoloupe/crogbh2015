class ServicesController < ApplicationController
  def category
    # this should be the index action on the categories controller
    raise ActionController::RoutingError.new('Not Found') if params['category'].nil?
    @category      = params['category'].to_sym
    @category_name = params['category']
                     .split('-')
                     .map(&:capitalize)
                     .join(' ')
    render 'category'
  end

  def new
  end

  def create
    @service = Service.new service_params
    if @service.save
      redirect_to @service
    else
      render :new
    end
  end

  private

  def service_params
    params.permit :name, :description, :website
  end
end
