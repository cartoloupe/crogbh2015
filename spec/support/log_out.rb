def log_out
  request.env['warden'].stub(:authenticate!)
    .and_throw(:warden, {:scope => :user})
end
