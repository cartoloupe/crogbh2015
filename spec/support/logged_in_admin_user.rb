shared_context 'logged in admin user' do
  let(:logged_in_user) { create :user, details: create(:admin_user_detail) }
  allow(request.env['warden']).to receive(:authenticate!) { logged_in_user }
  allow(controller).to receive(:current_user) { logged_in_user }
end
