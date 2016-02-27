class AddJobSalaryDepartmentToActions < ActiveRecord::Migration
  def change
    add_column :actions, :salary_old, :integer
    add_column :actions, :salary_new, :integer
    add_column :actions, :job_id_old, :integer
    add_column :actions, :job_id_new, :integer
    add_column :actions, :department_id_old, :integer
    add_column :actions, :department_id_new, :integer
    
    add_index :actions, :job_id_old
    add_index :actions, :job_id_new
    add_index :actions, :department_id_old
    add_index :actions, :department_id_new
  end
end
