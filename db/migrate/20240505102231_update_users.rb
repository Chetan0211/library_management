class UpdateUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :is_admin_user, :boolean, :default => false
  end
end
