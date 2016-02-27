class Job < ActiveRecord::Base
  
  # Relationships
  has_many :employees
  
end
