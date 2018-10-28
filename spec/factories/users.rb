FactoryBot.define do
  factory :user do
    first_name  { 'Kilmer' }
    last_name   { 'Luiz' }
    sequence :email do |n|
      "kilmer#{n}@email.com"
    end
    password    { 'qweasd' }
  end
end
