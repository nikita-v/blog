# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Bob"
    email "bob@example.com"
    password "12345678"
    confirmed_at Time.now
    factory :admin do
      role 'admin'
    end
  end
end
