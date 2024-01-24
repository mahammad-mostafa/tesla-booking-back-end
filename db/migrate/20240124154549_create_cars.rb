class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :car_model_name
      t.string :image
      t.text :description
      t.decimal :rental_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
