require 'rails_helper'

describe ServiceController do
  describe 'GET #category' do
    let(:a_category_key) { :employment }

    it 'assigns @category to the appropriate category' do
      get :category, category: a_category_key
      category = assigns(:category)
      expect(category).to be_a Category
      expect(category.key).to eq a_category_key
    end

    it 'renders the category template' do
      get :category, category: a_category_key
      expect(response).to render_template :category
    end
  end
end
