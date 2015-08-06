class EndUserController < ApplicationController
  def new
    return redirect_to end_user_url(CurrentUser.record) if CurrentUser.end_user?
    return render_404 unless CurrentUser.none?

    @user = User.new details: EndUserDetail.new
    render 'signup'
  end

  def show
    return redirect_to login_url if CurrentUser.none?
    return render_404 unless CurrentUser.end_user?

    @user = CurrentUser.record
    render 'profile'
  end

  def edit
    if params[:end_user_id]
      return render_404 unless CurrentUser.admin?
      @user = User.find_by id: params[:end_user_id].to_i
      return render_404 if @user.nil? || @user.details.class != EndUserDetail
    else
      return redirect_to login_url if CurrentUser.none?
      return render_404 unless CurrentUser.end_user?
      @user = CurrentUser.record
    end

    render 'edit'
  end

  def create
    return render_404 unless CurrentUser.none?

    details = EndUserDetail.new detail_parameters
    @user   = User.new user_parameters

    @user.details = details

    if details.valid? && @user.valid?
      details.save
      @user.save
      redirect_to account_url
    else
      render 'signup'
    end
  end

  private

  def user_parameters
    @user_parameters ||= params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
    )
  end

  def detail_parameters
    @details_parameters ||= params.require(:details).permit(
      :address,
      :city,
      :gender,
      :phone,
      :state,
      :zip,
    )
  end
end
