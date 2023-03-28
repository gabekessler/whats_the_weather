class AddressPresenter
    # INPUT: Address object
    # OUTPUT: Formatted string

    def initialize(address)
        @address = address
    end

    def display
        if @address.nil?
            "We're sorry, but we cannot find that address."
        else
            "#{@address.street.titleize}<br />#{@address.city.titleize}, #{@address.state.upcase} #{@address.zipcode.to_s}"
        end
    end
end