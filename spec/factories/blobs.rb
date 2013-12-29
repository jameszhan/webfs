# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blob do
    digest "MyString"
    uri "MyString"
    size "MyString"
    content_type "MyString"
    name "MyString"
  end
end
