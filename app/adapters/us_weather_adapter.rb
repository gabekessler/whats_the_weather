class UsWeatherAdapter
    # INPUT: @address
    # OUTPUT: Hash - temperature:integer, forecast:string

    # This adapter takes the Address object and gives a weather forcast [temperature, detailed_forcast] from the weather.gov API
    # https://www.weather.gov/documentation/services-web-api

    class << self
        def fetch_weather(address)
            begin
                parsed_weather = get_weather_info(address)
   
                weather_output(parsed_weather["temperature"], parsed_weather["detailedForecast"])
            rescue => e
                Rails.logger.debug("ERROR #{e}")
            end
        end

        private

        def get_weather_info(address)
            grid = get_grid_info(address.geocode)
            weather = HTTParty.get("https://api.weather.gov/gridpoints/#{grid["cwa"]}/#{grid["gridX"]},#{grid["gridY"]}/forecast", headers: { 
                "Accept" => "application/json" 
            })

            JSON.parse(weather.body)["properties"]["periods"][0]
        end

        def get_grid_info(lat_lang)
            grid = HTTParty.get("https://api.weather.gov/points/#{lat_lang.first},#{lat_lang.last}", headers: { 
                "Accept" => "application/json" 
            })

            JSON.parse(grid.body)["properties"]
        end

        def weather_output(temperature, detailed_forcast)
            {temperature: temperature, forecast: detailed_forcast}
        end
    end
end