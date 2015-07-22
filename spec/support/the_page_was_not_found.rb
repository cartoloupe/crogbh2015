shared_examples 'the page was not found' do
  it 'returns a 404' do
    expect(response.status).to eq 404
  end
end
