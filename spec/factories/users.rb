FactoryBot.define do
  factory :user do
    first_name  { 'Kilmer' }
    last_name   { 'Luiz' }
    email       { 'kilmer@email.com' }
    password    { 'qweasd' }
  end
end
