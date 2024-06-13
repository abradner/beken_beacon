class DevicesController < ApplicationController

  def index
    devices = Device.all
    render json: devices
  end

  def show
    device = Device.find(params[:id])
    render json: device
  end

  def create
    device = Device.create(device_params)
    render json: device
  end

  private

  def device_params
    params.require(:device).permit(:alias, :mac, :ip)
  end
end
