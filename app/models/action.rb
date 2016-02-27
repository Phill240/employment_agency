class Action < ActiveRecord::Base
    
  # Relationships
  belongs_to :employee
  belongs_to :department_old, class_name: "Department", foreign_key: "department_id_old" 
  belongs_to :department_new, class_name: "Department", foreign_key: "department_id_new" 
  belongs_to :job_old, class_name: "Job", foreign_key: "job_id_old" 
  belongs_to :job_new, class_name: "Job", foreign_key: "job_id_new"   
  
  def type_text    
  end
  
  def type_class
  end
  
end
