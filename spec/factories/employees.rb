FactoryGirl.define do
  factory :employee do
    first_name "John"
    last_name "Smith"
    salary 100000
    
    association :job
    association :department
  end
end