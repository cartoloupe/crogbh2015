def log_in_as user
  allow(CurrentUser).to receive(:record) { user }
end
