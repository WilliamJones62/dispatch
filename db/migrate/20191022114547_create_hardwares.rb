class CreateHardwares < ActiveRecord::Migration[5.1]
  def change
    create_table :hardwares do |t|
      t.string :owner
      t.string :serial_number

      t.timestamps
    end
  end
end
