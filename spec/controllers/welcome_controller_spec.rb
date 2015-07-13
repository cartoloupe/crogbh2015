require 'rails_helper'

describe WelcomeController do
  describe 'GET #index' do
    it 'assigns @categories with an Arary of Category objects' do
      get :index
      categories = assigns(:categories)
      expect(categories).to be_an Array
      categories.each do |category|
        expect(category).to be_a Category
      end
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
