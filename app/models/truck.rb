class Truck < ApplicationRecord
  has_many :truck_finances, inverse_of: :truck, :dependent => :destroy
  has_many :truck_its, inverse_of: :truck, :dependent => :destroy
end
