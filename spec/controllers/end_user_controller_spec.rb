require 'rails_helper'

describe EndUserController do
  # helpers

  def user_matches_params user, params
    expect(user).to match_hash params[:user]
    expect(user.details).to match_hash params[:details]
    true
  end

  # lets

  let(:an_end_users_attributes)         { attributes_for :user }
  let(:an_end_users_details_attributes) { attributes_for :end_user_detail }
  let(:an_admin_user)                   { create :user, :administrator }
  let(:an_end_user)                     { create :user }
  let(:the_current_user)                { nil }
  let(:logged_in_user)                  { controller.current_user }

  let(:an_end_user_details) do
    create(
      :end_user_detail,
      **end_user_params[:details],
    )
  end

  let(:an_end_user) do
    create(
      :user,
      **end_user_params[:user],
      details: an_end_user_details,
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

  # befores

  before :each do
    log_in_as the_current_user
  end

  # tests

  describe 'GET #new' do
    before :each do
      get :new
    end

    context 'while logged in as an end user' do
      let(:the_current_user) { an_end_user }
      it_behaves_like 'end user account redirection'
    end

    context 'while logged in as an administrator' do
      let(:the_current_user) { an_admin_user }
      it_behaves_like 'the page was not found'
    end

    context 'while not logged in' do
      it 'assigns @user to a new User' do
        user = assigns :user
        expect(user).to be_a(User).and be_new_record
        expect(user.details).to be_a(EndUserDetail).and be_new_record
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
          expect(assigns :user).to eq the_current_user
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
          expect(assigns :user).to eq the_current_user
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
            expect(assigns :user).to eq target_user
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
    before :each do |example|
      unless example.metadata[:skip_before]
        post :create, **end_user_params
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
          expect { post :create, **end_user_params }
            .to change { User.count }.by(1)
            .and change { EndUserDetail.count }.by(1)
        end

        it_behaves_like 'end user account redirection'
      end

      context 'with invalid data' do
        let(:end_user_params) do
          super().tap do |params|
            params[:user][:email] = ''
          end
        end

        it 'renders the new user form' do
          expect(response).to render_template :signup
        end

        it 'does not create a new User', skip_before: true do
          expect { post :create, **end_user_params }
          .not_to change { User.count }
        end

        it 'does not create a new EndUserDetail', skip_before: true do
          expect { post :create, **end_user_params }
          .not_to change { EndUserDetail.count }
        end

        xit 'does something meaningful with error messages'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with no user id' do
      before :each do
        post :update, **updated_end_user_params
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
          expect(assigns :user).to eq the_current_user
        end

        context 'with valid attributes' do
          it 'updated the current user' do
            user = assigns :user
            expect(user_matches_params(user, updated_end_user_params)).to be true
            expect(user).to be_valid
          end

          it_behaves_like 'end user account redirection'

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
            expect(assigns :user).to eq the_current_user
          end

          it 'does not update the user' do
            user = assigns :user
            expect(user).to be_changed
            expect(user).not_to be_valid
          end

          xit 'displays a flash error'
        end
      end
    end

    context 'with a user id' do
      before :each do
        post :update, end_user_id: an_end_user.try(:id), **updated_end_user_params
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
          expect(assigns :user).to eq an_end_user
        end

        context 'with valid attributes' do
          it { is_expected.to redirect_to end_user_url(an_end_user) }

          xit 'updates the user'
          xit 'it displays a flash message'
        end

        context 'with invalid attributes' do
          it 'displays the edit form' do
            expect(response).to render_template :edit
          end

          xit 'does not update the user'
          xit 'displays a flash warning'
        end
      end
    end
  end
end
