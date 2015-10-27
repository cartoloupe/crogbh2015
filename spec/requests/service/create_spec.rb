require 'rails_helper'

describe 'Service creation', type: :request do
  # Lets

  let(:description) { Faker::Lorem.paragraph }
  let(:name)        { Faker::Company.name }
  let(:service)     { Service.last }

  let(:params) do
    {
      description: description,
      name:        name,
    }
  end

  # Before

  before :each do
    post services_url, params
  end

  # Tests

  context 'with valid parameters' do
    it { is_expected.to redirect_to service }
  end

  context 'with invalid parameters' do
    let(:name) { '' }
    it { is_expected.to render_template :new }
  end
end
