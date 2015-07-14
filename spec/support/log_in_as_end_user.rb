def log_in_as_end_user
  @logged_in_user = create :user
  allow(request.env['warden']).to receive(:authenticate!) { @logged_in_user }
  allow(controller).to receive(:current_user) { @logged_in_user }
end
