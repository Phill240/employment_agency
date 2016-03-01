class Employee < ActiveRecord::Base
  
  # Relationships
  belongs_to :job
  belongs_to :department
  has_many :actions
  has_many :hire_actions
  has_many :transfer_actions
  has_many :fire_actions
  
  
  # Additional atribute that is used for dismissing or moving an employee
  attr_accessor :action_date  
  
  
  # Validations  
  validates :first_name, :last_name, :job_id, :department_id, :salary,  presence: true  
  validate { errors.add(:action_date, "must be a valid date") unless action_date.blank? || (DateTime.parse(action_date) rescue false) }
  
  
  # Callbacks
  after_create :save_hire_action
  after_update :save_update_action
    
  TRANSFER_FIELDS = [:job_id, :department_id, :salary]
  
  
  def full_name    
    "#{first_name} #{last_name}"
  end
  
  
  private
  
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
    
    changes = { :date => get_action_date }
    fields.each do |k, v|
      changes["#{k}_old"] = Array.wrap(v).first
      changes["#{k}_new"] = Array.wrap(v).last
    end    
    self.transfer_actions.create changes
  end
  
  def save_dismiss_action
    self.fire_actions.create({ :date => get_action_date })        
  end
  
  def get_action_date
    self.action_date.present? ? self.action_date : self.updated_at
  end
  
end
