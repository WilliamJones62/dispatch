class RemoveDispatchFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :Dispatch, :boolean
  end
end
