class Department < ActiveRecord::Base
  
  # Relationships
  has_many :employees
  
end
