class Weather < ApplicationRecord
    belongs_to :address

    validates_presence_of :forecast, :temperature
end
