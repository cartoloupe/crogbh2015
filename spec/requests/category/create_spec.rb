require 'rails_helper'

describe 'Category creation', type: :request do
  # Lets

  let(:category) { Category.last }
  let(:name)     { Faker::Commerce.department }

  let(:params) do
    {
      name: name
    }
  end

  # Before

  before :each do
    post categories_url, params
  end

  # Tests

  context 'with valid parameters' do
    it { is_expected.to redirect_to category }
  end

  context 'without a name' do
    let(:name) { '' }
    it { is_expected.to render_template :new }
  end
end
