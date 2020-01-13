class CreateTruckFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :truck_finances do |t|
      t.integer :truck_id
      t.string :wexcard
      t.string :ez_pass

      t.timestamps
    end
  end
end
