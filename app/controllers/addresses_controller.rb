class AddressesController < ApplicationController

  before_action :set_address, only: %i[ show edit update destroy ]
  # TODO: edit, update, destroy, index actions for admin areas
  before_action :redirect_to_new, only: %i[ edit update destroy index]

  # GET /addresses
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  def show
    @new_address = Address.new
    get_display_elements
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    weather = get_weather

    # TODO: refactor out instance_of?.
    # Temp fix to skip weather build for addresses that produce lat/long outside of the scope of the adapter.
    @address.build_weather(temperature: weather[:temperature], forecast: weather[:forecast]) if !weather.instance_of? Integer

    if @address.save
      redirect_to @address
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      redirect_to @address, notice: "Address was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: "Address was successfully destroyed."
  end

  private
    
    def get_display_elements
      @display_address = AddressPresenter.new(@address).display
      @cached = is_cached?
      @display_weather = WeatherPresenter.new(@address.weather).forecast
      set_weather_cookie
    end

    def is_cached?
      cookies().key?(@address.zipcode.to_s)
    end

    # Look for the cookie with the weather.id and use that to lookup Weather record
    # Or call the GetForecast service
    def get_weather
      if cookies().key?(@address.zipcode.to_s)
        Weather.find(cookies[@address.zipcode.to_s.to_sym])
      else
        GetForecast.new(@address).call
      end
    end

    def set_weather_cookie
      if @address.weather
        cookies[@address.zipcode.to_s.to_sym] = {value: @address.weather.id, expires: 30.minutes}
      end
    end

    def redirect_to_new
      redirect_to new_address_url(address: Address.last)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:street, :city, :state, :zipcode, :country, :latitude, :longitude)
    end
end
