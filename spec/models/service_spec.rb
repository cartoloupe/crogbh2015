require 'rails_helper'

describe Service, type: :model do
  let(:service)            { build :service, **service_attributes }
  let(:service_attributes) { Hash[] }

  subject { service }

  context 'without a name' do
    let(:service_attributes) { super().merge name: '' }
    it { is_expected.not_to be_valid }
  end

  context 'without a description' do
    let(:service_attributes) { super().merge description: '' }
    it { is_expected.not_to be_valid }
  end
end
