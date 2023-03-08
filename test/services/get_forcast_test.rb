require "test_helper"

class GetForecastTest < ActiveSupport::TestCase
    setup do
        @address = addresses(:good)
        @bad_address = addresses(:bad)
    end

    test "should return a hash with good params" do
        service = GetForecast.new(@address).call
        assert_equal service, {"temperature": 74, "forecast": "windy"}
    end
end