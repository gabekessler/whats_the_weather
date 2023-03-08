class GetForecast
    require_relative '../adapters/us_weather_adapter'
    require_relative '../adapters/fake_weather_adapter'

    LocationNotFound = Class.new(StandardError)

    def initialize(address)
        @address = address
    end

    def call
        if Rails.env.test?
            FakeWeatherAdapter.fetch_weather(@address)
        else
            UsWeatherAdapter.fetch_weather(@address)
        end
    rescue
        raise LocationNotFound
    end
end