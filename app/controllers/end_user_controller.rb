class EndUserController < ApplicationController
  def new
    @user   = User.new
    @detail = EndUserDetail.new
    render 'end_user_form'
  end

  def create
    @detail = EndUserDetail.new detail_parameters
    @user   = User.new user_parameters.merge(detail: @detail)
    if @detail.valid? && @user.valid?
      @detail.save
      @user.save
      redirect_to root_path
    else
      render 'end_user_form'
    end
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
    @detail_parameters ||= params.require(:detail).permit(
      :gender,
      :phone_number,
      :address,
      :city,
      :state,
    )
  end
end
