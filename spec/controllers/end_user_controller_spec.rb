require 'rails_helper'

describe EndUserController do
  # describe 'GET #new' do
  #   context 'while not logged in' do
  #     before :each do
  #       get :new
  #       @user   = assigns :user
  #       @detail = assigns :detail
  #     end

  #     it 'assigns @user to a new User' do
  #       expect(@user).to be_a User
  #       expect(@user).to be_new_record
  #     end

  #     it 'assigns @detail to a new EndUserDetail' do
  #       expect(@detail).to be_an EndUserDetail
  #       expect(@detail).to be_new_record
  #     end

  #     it 'renders the end_user_form template' do
  #       expect(response).to render_template :signup
  #     end
  #   end
  # end

  # describe 'GET #edit with no parameters' do
  #   context 'while logged in as an end user' do
  #     include_context 'logged in end user'

  #     before :each do
  #       get :edit
  #       @user = assigns :user
  #     end

  #     it 'assigns @user to the logged in user' do
  #       expect(@user).to eq logged_in_user
  #     end

  #     it 'renders the edit template' do
  #       expect(response).to render_template :edit
  #     end
  #   end

  #   context 'while not logged in' do
  #     include_context 'logged out user'

  #     it 'redirects to the login page' do
  #       expect(response).to redirect_to end_user_signup_url
  #     end
  #   end
  # end

  # describe 'GET #edit with a user id' do
  #   context 'while logged in as an administrator' do
  #     include_context 'logged in admin user'

  #     let!(:end_user) { create :user }

  #     before :each do
  #       get :edit, end_user_id: end_user.id
  #       @user = assigns :user
  #     end

  #     it 'assigns @user to the proper end user' do
  #       expect(@user).to eq end_user
  #     end

  #     it 'renders the edit template' do
  #       expect(response).to render_template :edit
  #     end
  #   end

  #   context 'while logged in as an end user' do
  #     include_context 'logged in end user'

  #     it 'returns a 404' do
  #       expect(response.status).to eq 404
  #     end
  #   end

  #   context 'while not logged in' do
  #     include_context 'logged out user'

  #     it 'returns a 404' do
  #       expect(response.status).to eq 404
  #     end
  #   end
  # end

  describe 'POST #create' do
    let(:user_attributes)   { attributes_for :user }
    let(:detail_attributes) { attributes_for :end_user_detail }

    # context 'while not logged in' do
    #   context 'with valid data' do
    #     before :each do
    #       log_out
    #       post :create, user: user_attributes, detail: detail_attributes
    #       @user = assigns :user
    #     end

    #     it 'redirects to the users account page' do
    #       byebug
    #       expect(response).to redirect_to user_url(@user)
    #     end
    #   end
    # end

    context 'while logged in as an end user' do
      let(:user) { create :user }

      before :each do
        sign_in user
        byebug
        post :create
      end

      it 'returns a 404' do
        expect(response.status).to eq 404
      end
    end
  end
end
