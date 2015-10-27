require 'rails_helper'

describe 'Service updating', type: :request do
  # Lets

  let(:new_description) { Faker::Lorem.paragraph }
  let(:new_name)        { Faker::Company.name }
  let(:service)         { create :service }

  let(:params) do
    {
      description: new_description,
      name:        new_name,
    }
  end

  # Before

  before :each do
    put service_url(service), params
  end

  # Tests

  context 'with valid parameters' do
    it { is_expected.to change { service.description }.to { new_description } }
    it { is_expected.to change { service.name        }.to { new_name        } }
    it { is_expected.to redirect_to service }
  end

  context 'with invalid parameters' do
    let(:new_name) { '' }
    it { is_expected.not_to change { service.description }.to { new_description } }
    it { is_expected.not_to change { service.name        }.to { new_name        } }
    it { is_expected.to render_template :edit }
  end
end
