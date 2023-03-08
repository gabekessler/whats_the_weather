class FakeWeatherAdapter
    # INPUT: @address
    # OUTPUT: Hash - temperature:integer, forecast:string

    # This adapter takes the Address object and gives a weather forcast [temperature, detailed_forcast] from the weather.gov API
    # https://www.weather.gov/documentation/services-web-api

    @errors = {}
    @temperature = nil
    @detailed_forcast = nil

    class << self
        attr_accessor :errors, :temperature, :detailed_forcast

        def fetch_weather(address)
            {temperature: 74, forecast: "windy"}
        end
    end
end