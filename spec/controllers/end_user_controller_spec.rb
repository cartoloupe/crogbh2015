require 'rails_helper'

# *some* of these contexts omit the case for administrators this is because the
# routes file should be redirecting to the admin controller
#
# each user type per function are or should be tested in the functional spec

describe EndUserController do
  # helpers

  def user_matches_params user, params
    expect(user).to match_hash params[:user]
    expect(user.details).to match_hash params[:details]
  end

  # lets

  let(:an_end_users_attributes)         { attributes_for :user }
  let(:an_end_users_details_attributes) { attributes_for :end_user_detail }
  let(:an_admin_user)                   { create :user, :administrator }
  let(:an_end_user)                     { create :user }
  let(:the_current_user)                { nil }
  let(:logged_in_user)                  { controller.current_user }

  let(:an_end_user) do
    create(
      :user,
      **end_user_params[:user],
      details: end_user_params[:details],
    )
  end

  let(:end_user_params) do
    {
      user:    attributes_for(:user),
      details: attributes_for(:end_user_detail),
    }
  end

  let(:updated_end_user_params) do
    {
      user:    attributes_for(:user),
      details: attributes_for(:end_user_detail),
    }
  end

  # shared examples

  shared_examples 'the user was updated' do |user|
    specify 'the model was updated' do
      expect(user_matches_params(user, updated_end_user_params)) .to be_true
      expect(user).to be_valid
    end
  end

  shared_examples 'the user was not updated' do |user|
    specify 'the model was not updated' do
      expect(user_matches_params(user, end_user_params)).to be_true
      expect(user).not_to be_valid
    end
  end

  shared_examples 'user profile redirection' do
    it 'supplies the correct url' do
      expect(response).to redirect_to user_url(@user)
    end
  end

  # befores

  before :each do
    unless the_current_user.nil?
      log_in_as the_current_user
    else
      log_out
    end
  end

  # tests

  describe 'GET #new' do
    before :each do
      get :new
      @user = assigns :user
    end

    context 'while logged in as an end user' do
      let(:the_current_user) { an_end_user }
      it_behaves_like 'user profile redirection'
    end

    context 'while logged in as an administrator' do
      let(:the_current_user) { an_admin_user }
      it_behaves_like 'the page was not found'
    end

    context 'while not logged in' do
      it 'assigns @user to a new User' do
        expect(@user).to be_a(User).and be_new_record
        expect(@user.details).to be_a(EndUserDetail).and be_new_record
      end

      it 'renders the signup template' do
        expect(response).to render_template :signup
      end
    end
  end

  describe 'GET #show' do
    context 'with no parameters' do
      before :each do
        get :show
        @user = assigns :user
      end

      context 'while not logged in' do
        it_behaves_like 'it redirects to the login page'
      end

      context 'while logged in as an admin user' do
        let(:the_current_user) { an_admin_user }
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an end user' do
        let(:the_current_user) { an_end_user }

        it 'assigns @user to the appropriate user' do
          expect(@user).to eq the_current_user
        end

        it 'shows the profile for the user' do
          expect(response).to render_template :profile
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'with no parameters' do
      before :each do
        get :edit
        @user = assigns :user
      end

      context 'while not logged in' do
        it_behaves_like 'it redirects to the login page'
      end

      context 'while logged in as an admin user' do
        let(:the_current_user) { an_admin_user }
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an end user' do
        let(:the_current_user) { an_end_user }

        it 'assigns @user to the logged in user' do
          expect(@user).to eq current_user
        end

        it 'renders the edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'with a user id' do
      let(:target_user)    { create :user }
      let(:target_user_id) { target_user.id }

      before :each do
        get :edit, end_user_id: target_user_id
        @user = assigns :user
      end

      context 'while logged in as an end user' do
        let(:the_current_user) { an_end_user }
        it_behaves_like 'the page was not found'
      end

      context 'while not logged in' do
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an administrator' do
        let(:the_current_user) { an_admin_user }

        context 'for a valid user' do
          it 'assigns @user to the proper end user' do
            expect(@user).to eq target_user
          end

          it 'renders the edit template' do
            expect(response).to render_template :edit
          end
        end

        context 'for a non-existent user' do
          let(:target_user_id) { 0 }
          it_behaves_like 'the page was not found'
        end

        context 'for a user that is not an end user' do
          let(:target_user_id) { an_admin_user.id }
          it_behaves_like 'the page was not found'
        end
      end
    end
  end

  describe 'POST #create' do
    before :each do
      unless example.metadata[:skip_before]
        post :create, **end_user_params
        @user = assigns :user
      end
    end

    context 'while logged in as an end user' do
      let(:the_current_user) { an_end_user }
      it_behaves_like 'the page was not found'
    end

    context 'while logged in as an admin user' do
      let(:the_current_user) { an_admin_user }
      it_behaves_like 'the page was not found'
    end

    context 'while not logged in' do
      context 'with valid data' do
        it 'creates a new User with the proper attributes', skip_before: true do
          expect { post :create, **form_params }
            .to change(User.count).by(1)
            .and change(EndUserDetail.count).by(1)
        end

        it_behaves_like 'user profile redirection'
      end

      context 'with invalid data' do
        let(:end_user_params) do
          super().tap do |params|
            params[:user][:email] = ''
          end
        end

        it 'renders the new user form' do
          expect(response).to render_template :edit
        end

        it_behaves_like 'the user was not updated'

        xit 'does something meaningful with error messages'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with no user id' do
      before :each do
        post :update, **updated_end_user_params
        @user = assigns :user
      end

      context 'while not logged in' do
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an admin user' do
        let(:the_current_user) { an_admin_user }
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an end user' do
        let(:the_current_user) { an_end_user }

        it 'assigns @user to the current user' do
          expect(@user).to eq current_user
        end

        context 'with valid attributes' do
          it_behaves_like 'the user was updated'
          it_behaves_like 'user profile redirection'
          xit 'displays a flash message'
        end

        context 'with invalid attributes' do
          let(:updated_end_user_params) do
            super().tap do |params|
              params[:user][:email] = ''
            end
          end

          it 'renders the edit form' do
            expect(response).to render_template :edit
          end

          it 'assigns @user to the user attributes' do
            expect(@user).to eq current_user
          end

          it 'assigns @details to the details for the user' do
            expect(@details).to eq current_user.details
          end

          it 'does not update the user' do
            expect(@user.email).not_to eq form_params[:user][:email]
          end

          xit 'displays a flash error'
        end
      end
    end

    context 'with a user id' do
      before :each do
        post :update, end_user_id: an_end_user.try(:id), **form_params
        @user    = assigns :user
        @details = assigns :details
      end

      context 'while not logged in' do
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an end user' do
        let(:the_current_user) { an_end_user }
        it_behaves_like 'the page was not found'
      end

      context 'while logged in as an admin user' do
        let(:the_current_user) { an_admin_user }

        it 'assigns @user to the appropriate user' do
          expect(@user).to eq current_user
        end

        context 'with valid attributes' do
          it_behaves_like 'the user was updated'
          it_behaves_like 'user profile redirection'
          xit 'it displays a flash message'
        end

        context 'with invalid attributes' do
          it_behaves_like 'the user was not updated'

          it 'displays the edit form' do
            expect(response).to render_template :edit
          end

          xit 'displays a flash warning'
        end
      end
    end
  end
end
