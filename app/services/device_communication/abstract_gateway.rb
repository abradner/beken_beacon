# frozen_string_literal: true

module DeviceCommunication

  # this class is an interface for Device gateways including the GatewayCoordinator
  class AbstractGateway

    def initialize(*_)
      raise 'Cannot instantiate abstract class'
    end

    def get_status
      raise 'Not implemented'
    end

    def set_status(status)
      raise 'Not implemented'
    end

    def get_device
      @device
    end
  end
end