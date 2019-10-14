class AddDispatchToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :dispatch, :boolean
  end
end
