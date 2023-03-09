require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  # TODO: Stub or Mock the API calls made in the weather adapter and address geocode
  setup do
    @address = addresses(:good)
  end

  test "should get index" do
    get addresses_url
    assert_redirected_to new_address_url(address: Address.last)
  end

  test "should get new" do
    get new_address_url
    assert_response :success
  end

  # test "should have cached set if cookie found" do
  #   post addresses_url, params: { address: { city: @address.city, country: @address.country, state: @address.state, street: @address.street, zipcode: @address.zipcode } }
  #   get address_url(@address) 
  #   post addresses_url, params: { address: { city: @address.city, country: @address.country, state: @address.state, street: @address.street, zipcode: @address.zipcode } }

  #   assert_equal true, @controller.view_assigns['cached']
  # end

  test "should create address with correct params" do
    assert_difference("Address.count") do
      post addresses_url, params: { address: { city: @address.city, country: @address.country, state: @address.state, street: @address.street, zipcode: @address.zipcode } }
    end

    assert_redirected_to address_url(Address.last.id)
  end

  test "should not create an address with incorrect params" do
    address = addresses(:no_zipcode)
    assert_no_difference("Address.count") do
      post addresses_url, params: { address: { city: address.city, country: address.country, state: address.state, street: address.street, zipcode: address.zipcode } }
    end

    assert_response :unprocessable_entity
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_url(@address)
    assert_redirected_to new_address_url(address: Address.last)
  end

  test "should update address" do
    patch address_url(@address), params: { address: { city: @address.city, country: @address.country, latitude: @address.latitude, longitude: @address.longitude, state: @address.state, street: @address.street, zipcode: @address.zipcode } }
    assert_redirected_to new_address_url(address: Address.last)
  end

  test "should NOT destroy address" do
    assert_difference("Address.count", 0) do
      delete address_url(@address)
    end

    assert_redirected_to new_address_url(address: Address.last)
  end
end
