class CreatePerformanceDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :performance_details do |t|
      t.references :car, null: false, foreign_key: true
      t.string :detail

      t.timestamps
    end
  end
end
