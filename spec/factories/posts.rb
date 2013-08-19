# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user_id 1
    title "MyString"
    short_body "MyText"
    full_body "Text"
  end
end
