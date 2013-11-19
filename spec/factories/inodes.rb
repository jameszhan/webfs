# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inode do
    shasum "MyString"
    uri "MyString"
    size 1
    content_type "MyString"
    name "MyString"
  end
end
