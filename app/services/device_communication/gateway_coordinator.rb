# frozen_string_literal: true

module DeviceCommunication
  class GatewayCoordinator < AbstractGateway
    # There are a few different gateways that we can use to interact with the devices.
    # This class has two main responsibilities:
    # 1) coordinating the alternatives for a given device and deciding which one is the source of truth.
    # 2) delegating the calls to the correct gateway.
  end
end
