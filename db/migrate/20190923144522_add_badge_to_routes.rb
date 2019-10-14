class AddBadgeToRoutes < ActiveRecord::Migration[5.1]
  def change
    add_column :routes, :badge, :string
  end
end
