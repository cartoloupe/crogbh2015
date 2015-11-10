require 'rails_helper'

describe 'Category updating', type: :request do
  # Lets

  let(:new_attributes)      { attributes_for(:category) }
  let(:new_name)            { }
  let(:original_attributes) { attributes_for(:category) }
  let(:category)             { create :category, **original_attributes }

  let(:params) do
    {
      id:      category.id,
      category: new_attributes.tap do |attributes|
                 # override the name that factory girl provides if it's
                 # specified explicitly in a test
                 attributes[:name] = new_name if new_name
               end,
    }
  end

  let(:final_attributes) do
    category
    .reload
    .attributes
    .symbolize_keys
  end

  # Before

  before(:each) { put category_url(category), params }

  # Tests

  context 'with valid parameters' do
    it { is_expected.to redirect_to category }

    it 'updates the category attributes' do
      expect(final_attributes).to include new_attributes
    end
  end

  context 'with invalid parameters' do
    let(:new_name) { '' }

    it { is_expected.to render_template :edit }

    it 'does not update the category attributes' do
      expect(final_attributes).to include original_attributes
    end
  end
end
