require "test_helper"

class AddressTest < ActiveSupport::TestCase
  
  test "valid address" do
    address = addresses(:good)
    assert address.valid?
  end

  test "invalid without zipcode" do
    address = addresses(:no_zipcode)
    refute address.valid?
    assert_not_nil address.errors[:address]
  end

  test "invalid without street" do
    address = addresses(:no_street)
    refute address.valid?
    assert_not_nil address.errors[:address]
  end

  # TODO: possible issue with geocode assigning lat/long for invalid address
  # test "invalid can't get lat and long" do
  #   address = addresses(:no_geocode)
  #   refute address.valid?
  #   assert_not_nil address.errors[:address]
  # end
end
