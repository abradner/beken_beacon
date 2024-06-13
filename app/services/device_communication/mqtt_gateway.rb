# frozen_string_literal: true

module DeviceCommunication
  class MqttGateway
    # this class is a gateway to the MQTT broker - most likely the one integrated with Home Assistant
    # it creates an abstraction to MQTT, allowing us to query and set state for our various devices
    # at a lower level is responsible for publishing and subscribing to MQTT messages, but at a higher level
    # it can be used to interact with the devices in a more abstract way
    # it uses the ruby-mqtt gem to interact with the MQTT broker

    def self.subscribe(topic)
      client = MQTT::Client.connect('mqtt://localhost')
      client.get(topic)
    end

    def self.publish(topic, message)
      client = MQTT::Client.connect('mqtt://localhost')
      client.publish(topic, message)
      client.disconnect
    end
  end
end