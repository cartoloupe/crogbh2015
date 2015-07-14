shared_context 'logged in end user' do
  let(:logged_in_user) { create :user }
  allow(request.env['warden']).to receive(:authenticate!) { logged_in_user }
  allow(controller).to receive(:current_user) { logged_in_user }
end
