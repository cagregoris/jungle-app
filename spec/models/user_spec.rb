require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    it "validates :email, presence: true" do
      user = User.new(first_name: 'Bob', last_name: 'Vance', email: nil, password: 'abcdefgh', password_confirmation: 'abcdefgh')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it "validates :first_name, presence: true" do
      user = User.new(first_name:nil, last_name: 'Vance', email: 'bob@vance.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "validates :last_name, presence: true" do
      user = User.new(first_name:'Bob', last_name:nil, email: 'bob@vance.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it "validates :password = :password_confirmation" do
      user = User.new(first_name:'Bob', last_name:'Vance', email: 'bob@vance.com', password: 'abcdefgh', password_confirmation: 'abcdefghijk')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
    end

    it "validates :email is unique" do
      user1 = User.new(first_name:'Bob', last_name:'Vance', email:'bob@vance.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      user2 = User.new(first_name:'Bob', last_name:'Vance', email:'bob@vance.com', password: 'abcdefgh', password_confirmation: 'abcdefgh')
      user1.save
      user2.save
      expect(user1).to be_valid
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to eq ["Email has already been taken"]
    end
  end

  describe '.authenticate_with_credentials' do

    before(:all) do
      @user = User.create(first_name: 'Bob', last_name: 'Vance', email: 'bob@bobvance.com', password: "abcdefgh", password_confirmation: "abcdefgh")
    end

    it "should authenticate if credentials are correct" do
      user = User.authenticate_with_credentials('bob@bobvance.com', 'abcdefgh')
      expect(user).to be_a User
    end
    
    it "should still authenticate if there is space surrounding email" do
      user = User.authenticate_with_credentials(' bob@bobvance.com ', 'abcdefgh')
      expect(user).to be_a User
    end
    
    it "should still authenticate if email has uppercase letter" do
      user = User.authenticate_with_credentials(' bob@boBvance.com ', 'abcdefgh')
      expect(user).to be_a User
    end
    
  end

end
