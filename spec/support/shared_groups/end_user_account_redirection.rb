shared_examples 'end user account redirection' do
  it 'redirects to the end users account page' do
    expect(request).to redirect_to end_user_path(the_current_user)
  end
end
