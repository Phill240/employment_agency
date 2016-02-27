class AddJobAndDepartmentToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :job, index: true, foreign_key: true
    add_reference :employees, :department, index: true, foreign_key: true
  end
end
