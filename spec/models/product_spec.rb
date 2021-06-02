require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do 
      @category = Category.new(name: 'Electronics')
    end

    it 'validates :name, presence: true' do
      @product = Product.new(name: nil, price:50, quantity:10, category:@category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it 'validates :price, presence: true' do
      @product = Product.new(name: 'iPad', price_cents:nil, quantity:1, category:@category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
    end

    it 'validates :quantity, presence: true' do
      @product = Product.new(name: 'iPad', price_cents:10, quantity:nil, category:@category)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
    end

    it 'validates :category, presence: true' do
      @product = Product.new(name: 'iPad', price_cents:10, quantity:1000, category:nil)

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end

  end
end
