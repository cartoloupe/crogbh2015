require 'rails_helper'

describe Category, type: :model do
  let(:category)            { build :category, **category_attributes }
  let(:category_attributes) { Hash[] }

  subject { category }

  context 'without a name' do
    let(:category_attributes) { super().merge name: '' }
    it { is_expected.not_to be_valid }
  end
end
