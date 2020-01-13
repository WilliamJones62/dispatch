class TruckFinance < ApplicationRecord
  belongs_to :truck, :foreign_key => "truck_id"
end
