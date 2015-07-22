class EndUserController < ApplicationController
  def new
    # @user    = User.new
    # @details = EndUserDetail.new
    # render 'end_user_form'
  end

  def create
    # @details = EndUserDetail.new detail_parameters
    # @user    = User.new user_parameters.merge(details: @details)
    # if @details.valid? && @user.valid?
    #   @details.save
    #   @user.save
    #   redirect_to root_path
    # else
    #   render 'end_user_form'
    # end
  end

  def update
  end

  def edit
  end

  private

  def user_parameters
    @user_parameters ||= params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
    )
  end

  def detail_parameters
    @details_parameters ||= params.require(:detail).permit(
      :gender,
      :phone_number,
      :address,
      :city,
      :state,
    )
  end
end
