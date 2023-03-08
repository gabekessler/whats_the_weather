class Address < ApplicationRecord
    # Address
    # We really only care about the :zipcode for weather retrieval
    has_one :weather

    validates_presence_of :zipcode

    # This is the 
    geocoded_by :zipcode
    after_validation :geocode 
end
