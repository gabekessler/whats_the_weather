class Address < ApplicationRecord
    # Address
    # We really only care about the :street and :zipcode for weather retrieval
    has_one :weather

    validates_presence_of :street, :zipcode

    # We want to validate that the address can retrieve latitude and longitude. Otherwise the weather API will fail.
    validate :is_geolocated?

    # This is the geocoder gem method for getting latitude and longitude coordinates
    geocoded_by :formatted_address
    before_validation :geocode 

    def formatted_address
        [street, zipcode].compact.join(", ")  
    end

    def is_geolocated?
        errors.add(:address, "can't be located.") if !self.geocoded? 
    end
end
