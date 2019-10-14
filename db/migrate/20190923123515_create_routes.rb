class CreateRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.string :route_code
      t.string :truck
      t.string :driver
      t.date :route_date
      t.integer :user_id

      t.timestamps
    end
  end
end
