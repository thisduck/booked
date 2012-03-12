FactoryGirl.define do
  factory :user do
    name "joe"
    email "joe@example.com"
    handle "joe"
    type_of "user"
  end

  factory :admin, :class => :user do
    name "admin"
    email "admin@example.com"
    handle "admin"
    type_of "admin"
  end

  factory :editor, :class => :user do
    name "editor"
    email "editor@example.com"
    handle "editor"
    type_of "editor"
  end
end
