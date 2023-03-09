require "test_helper"

class WeatherTest < ActiveSupport::TestCase
  test "valid weather" do
    weather = weathers(:good)
    assert weather.valid?
  end

  test "invalid without zipcode" do
    weather = weathers(:no_temperature)
    refute weather.valid?
    assert_not_nil weather.errors[:temperature]
  end

  test "invalid without street" do
    weather = weathers(:no_forecast)
    refute weather.valid?
    assert_not_nil weather.errors[:forecast]
  end
end
