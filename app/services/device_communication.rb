# frozen_string_literal: true

module DeviceCommunication

  Device = Struct.new(*%i[id ])
  Action = Struct.new(:name, :type, :status)
  Query = Struct.new(:name, :type, :status)
end
