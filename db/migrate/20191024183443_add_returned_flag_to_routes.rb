class AddReturnedFlagToRoutes < ActiveRecord::Migration[5.1]
  def change
    add_column :routes, :returned_flag, :boolean
  end
end
