require "test_helper"

class GetForecastTest < ActiveSupport::TestCase
    setup do
        @address = addresses(:good)
        @bad_address = addresses(:no_geocode)
    end

    test "should return a hash with good params" do
        service = GetForecast.new(@address).call
        assert_equal service, {"temperature": 74, "forecast": "windy"}
    end

    # TODO: test for error handling
    # test "should return an Integer with bad params" do
    #     service = GetForecast.new(@bad_address).call
    #     assert_equal service, {"temperature": 74, "forecast": "windy"}
    # end
end