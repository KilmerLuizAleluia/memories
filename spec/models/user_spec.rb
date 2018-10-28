require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is not valid without a first_name' do
      user = User.new(first_name: nil, last_name: 'Luiz', email: 'kl@email.com', password: 'passwd')
      expect(user).to_not be_valid
    end
    it 'is not valid without a last_name' do
      user = User.new(first_name: 'Kilmer', last_name: nil, email: 'kl@email.com', password: 'passwd')
      expect(user).to_not be_valid
    end
    it 'is not valid without a email' do
      user = User.new(first_name: 'Kilmer', last_name: 'Luiz', email: nil, password: 'passwd')
      expect(user).to_not be_valid
    end
  end

  context 'methods' do
    describe '#name' do
      it '' do
        user = FactoryBot.create(:user, first_name: 'Gabriel', last_name: 'Toledo')
        expect(user.name).to eq 'Gabriel Toledo'
      end
    end
  end
end
