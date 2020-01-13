class CreateTruckIts < ActiveRecord::Migration[5.1]
  def change
    create_table :truck_its do |t|
      t.string :temp_status
      t.boolean :temp_verified
      t.integer :truck_id

      t.timestamps
    end
  end
end
