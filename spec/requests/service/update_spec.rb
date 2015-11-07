require 'rails_helper'

describe 'Service updating', type: :request do
  # Lets

  let(:new_attributes)      { attributes_for(:service) }
  let(:new_name)            { }
  let(:original_attributes) { attributes_for(:service) }
  let(:service)             { create :service, **original_attributes }

  let(:params) do
    {
      id:      service.id,
      service: new_attributes.tap do |attributes|
                 # override the name that factory girl provides if it's
                 # specified explicitly in a test
                 attributes[:name] = new_name if new_name
               end,
    }
  end

  let(:final_attributes) do
    service
    .reload
    .attributes
    .symbolize_keys
  end

  # Before

  before(:each) { put service_url(service), params }

  # Tests

  context 'with valid parameters' do
    it { is_expected.to redirect_to service }

    it 'updates the service attributes' do
      expect(final_attributes).to include new_attributes
    end
  end

  context 'with invalid parameters' do
    let(:new_name) { '' }

    it { is_expected.to render_template :edit }

    it 'does not update the service attributes' do
      expect(final_attributes).to include original_attributes
    end
  end
end
