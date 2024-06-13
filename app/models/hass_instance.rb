# frozen_string_literal: true

# A stub model that - for now - uses config
class HassInstance
  SCHEMA = %i[id name url access_token].freeze
  Schema = Struct.new(*self::SCHEMA, keyword_init: true)

  include YamlModel
end
