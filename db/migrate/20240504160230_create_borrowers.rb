class CreateBorrowers < ActiveRecord::Migration[7.1]
  def change
    create_table :borrowers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status, default:"requested"
      t.text :comments

      t.timestamps
    end
  end
end
