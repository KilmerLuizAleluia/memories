require 'rails_helper'

RSpec.describe Memory, type: :model do
  context 'relations' do
    it { should belong_to :user }
  end

  context 'validations' do
    it 'is not valid without a first_name' do
      memory = Memory.new(description: nil)
      expect(memory).to_not be_valid
    end
  end

  context 'model methods' do
    describe '#formatted_date' do
      it 'should format memory date' do
        memory = FactoryBot.create :memory
        expect(memory.formatted_date).to eq Date.today.strftime('%B %d, %Y')
      end
    end
  end
end
