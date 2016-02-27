class Employee < ActiveRecord::Base
  
  # Relationships
  belongs_to :job
  belongs_to :department
  has_many :actions
  has_many :hire_actions
  has_many :transfer_actions
  has_many :fire_actions
  
  
  # Validations  
  validates :first_name, :last_name, :job_id, :department_id, :salary,  presence: true
  
  
  # Callbacks
  before_update :check_is_fired
  after_create :save_hire_action
  after_update :save_update_action
  
  attr_accessor :action_date
  
  TRANSFER_FIELDS = [:job_id, :department_id, :salary]
  
  
  def full_name    
    "#{first_name} #{last_name}"
  end
  
  
  private
  
  def check_is_fired
    return true unless self.is_fired
    self.errors.add(:base, "Cannot update a fired employee")
    false
  end
  
  def save_hire_action
    self.hire_actions.create({ 
        :date => self.created_at,
        :job_id_new => self.job_id,
        :department_id_new => self.department_id,
        :salary_new => self.salary
    })    
  end
  
  def save_update_action
    transfer_fields = self.changes.to_h.pick(TRANSFER_FIELDS)
    save_transfer_action(transfer_fields)
    save_dismiss_action if self.is_fired
  end
  
  def save_transfer_action(fields)
    return if fields.empty?
    
    changes = { :date => self.updated_at }
    fields.each do |k, v|
      changes["#{k}_old"] = Array.wrap(v).first
      changes["#{k}_new"] = Array.wrap(v).last
    end    
    self.transfer_actions.create changes
  end
  
  def save_dismiss_action
    self.fire_actions.create({ :date => self.updated_at })        
  end
  
  
  
end
