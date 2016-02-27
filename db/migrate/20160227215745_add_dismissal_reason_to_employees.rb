class AddDismissalReasonToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :is_fired, :boolean
    add_column :employees, :dismissal_reason, :text
  end
end
