class CreateTaxReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_references do |t|
      t.integer :year
      t.float :hourly_wage
      t.integer :min_monthly_hours
      t.float :worker_percentage
      t.float :employer_percentage

      t.timestamps
    end
  end
end
