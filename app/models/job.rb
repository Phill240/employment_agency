class Job < ActiveRecord::Base
  
  # Relationships
  has_many :employees
    
  # Validations  
  validates :name, presence: true
  
end
