class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :price
      t.integer :available_quantity
      t.integer :total_quantity
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
