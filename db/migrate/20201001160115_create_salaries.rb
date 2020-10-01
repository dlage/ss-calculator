class CreateSalaries < ActiveRecord::Migration[6.0]
  def change
    create_table :salaries do |t|
      t.integer :year
      t.float :hourly_rate
      t.json :hour_table

      t.timestamps
    end
  end
end
