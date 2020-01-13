class CreateTrucks < ActiveRecord::Migration[5.1]
  def change
    create_table :trucks do |t|
      t.string :location
      t.string :truck_number
      t.boolean :start_decommission

      t.timestamps
    end
  end
end
