class AddReturnedFlagToDispatchLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dispatch_logs, :returned_flag, :boolean
  end
end
