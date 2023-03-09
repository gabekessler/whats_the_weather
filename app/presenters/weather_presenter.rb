class WeatherPresenter
    # INPUT Weather object or nil
    # OUTPUT Formatted String

    def initialize(weather)
        @weather = weather
    end

    def forecast
        if @weather.nil?
            "We're sorry, but we cannot find the weather forecast for that address."
        else
            (formatted_temperature + "<br />" + formatted_forecast)
        end
    end

    private
    
    def formatted_temperature
         "The current temperature is #{@weather["temperature"]}."
    end
    
    def formatted_forecast
        @weather["forecast"].to_s
    end
end