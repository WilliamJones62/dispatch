class AddIssuedFlagToRoutes < ActiveRecord::Migration[5.1]
  def change
    add_column :routes, :issued_flag, :boolean
  end
end
