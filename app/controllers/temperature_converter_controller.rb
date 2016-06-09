class TemperatureConverterController < ApplicationController
  def index
  end
  def create
    @temperature = params[:temperature]
    @error = "Please enter a valid number!" unless @temperature.to_i.to_s == @temperature
    @fahrenheit = (@temperature.to_i * 1.8 + 32)
  render :index
  end
end
