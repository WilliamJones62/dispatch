class CreateDispatchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dispatch_logs do |t|
      t.string :route_code
      t.string :truck
      t.string :driver
      t.date :route_date
      t.string :badge
      t.string :wexcard
      t.string :ez_pass
      t.string :tablet

      t.timestamps
    end
  end
end
