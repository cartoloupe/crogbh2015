def log_in_as user
  allow(controller).to receive(:current_user) { user }
end
