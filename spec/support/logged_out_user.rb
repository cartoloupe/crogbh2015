shared_context 'logged out user' do
  request.env['warden'].stub(:authenticate!)
    .and_throw(:warden, {:scope => :user})
end
