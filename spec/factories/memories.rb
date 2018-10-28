FactoryBot.define do
  factory :memory do
    sequence :description do |n|
      "Memory #{n}"
    end
    date    { Date.today }
    weather { 'Light rain' }
    local   { 'Brasilia' }
    before(:create) do |memory|
      memory.user = FactoryBot.build(:user)
    end
  end
end
