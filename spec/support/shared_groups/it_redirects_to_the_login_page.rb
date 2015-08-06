shared_examples 'it redirects to the login page' do
  it 'supplies the correct url' do
    expect(response).to redirect_to login_url
  end
end
