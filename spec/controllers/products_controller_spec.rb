require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#index' do
    it 'gets a list of products' do
      products = FactoryBot.create_list(:product, 3)
      #products = []
      #products << Product.create(title: 'SCSS book', description: 'This is discription', price: 9.99)
      #products << Product.create(title: 'SCSS book', description: 'This is discription', price: 8.99)
      get :index
      expect(assigns(:products)).to eq products
    end
  end
end
