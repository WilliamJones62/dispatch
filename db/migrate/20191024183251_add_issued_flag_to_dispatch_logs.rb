class AddIssuedFlagToDispatchLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dispatch_logs, :issued_flag, :boolean
  end
end
