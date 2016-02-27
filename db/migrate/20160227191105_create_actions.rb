class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :type
      t.timestamp :date
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
