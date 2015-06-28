class EndUserController < ApplicationController
  def new
    @user = User.new
    @end_user_detail = EndUserDetail.new
    render 'end_user_form'
  end
end
