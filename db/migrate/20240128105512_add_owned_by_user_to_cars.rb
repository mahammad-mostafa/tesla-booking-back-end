class AddOwnedByUserToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :owned_by_user, :boolean
  end
end
