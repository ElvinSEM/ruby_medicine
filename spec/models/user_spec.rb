require 'rails_helper'
#
# RSpec.describe User, type: :model do
#   it 'is valid with a username, email, and password' do
#     user = User.new(username: 'johndoe', email: 'johndoe@example.com', password: 'password')
#     expect(user).to be_valid
#   end
#
#   it 'is invalid without a username' do
#     user = User.new(username: nil, email: 'test@example.com', password: 'password')
#     user.valid?
#     expect(user.errors[:username]).to include("can't be blank")
#   end
#
#   it 'is invalid without an email' do
#     user = User.new(username: 'johndoe', email: nil, password: 'password')
#     user.valid?
#     expect(user.errors[:email]).to include("can't be blank")
#   end
#
#   it 'is invalid without a password' do
#     user = User.new(username: 'johndoe', email: 'test@example.com', password: nil)
#     user.valid?
#     expect(user.errors[:password]).to include("can't be blank")
#   end
#
#   it 'is invalid with a duplicate email address' do
#     created_user = User.create(username: 'johndoe', email: 'tester@example.com', password: 'password')
#     expect(created_user).to be_persisted
#
#     user_with_duplicate_email = User.new(username: 'janedoe', email: 'tester@example.com', password: 'password')
#     user_with_duplicate_email.valid?
#     expect(user_with_duplicate_email.errors[:email]).to include("has already been taken")
#   end
#
#   it 'is invalid with a wrong email format' do
#     user = User.new(username: 'johndoe', email: 'not_an_email', password: 'password')
#     user.valid?
#     expect(user.errors[:email]).to include("is invalid")
#   end
#
#   it 'is invalid if the password is too short' do
#     user = User.new(username: 'johndoe', email: 'test@example.com', password: 'short')
#     user.valid?
#     expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
#   end
# end

# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  describe 'Creation' do
    it 'can be created' do
      user = FactoryBot.create(:user)
      expect(user.persisted?).to be(true)
    end
  end

  describe 'Associations' do
    it { should have_many(:appointments) }
    it { should have_many(:doctors).through(:appointments) }
  end

  # Добавьте другие тесты валидаций здесь...
end