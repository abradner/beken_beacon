# frozen_string_literal: true

# YamlModel allows us to define models that are backed by YAML files.
# This is intended for static data that is not expected to change frequently.
# The YAML file should:
#  - be placed in the config/model_data directory.
#  - be named after the model, pluralized, and with a .yml extension.
#  - contain an array of records, each record being a hash.
#  - contain a unique id for each record.
#  - contain all the attributes defined in the Schema.
# Schema:
#  - should be defined as a Struct with the same attributes as the YAML records.
#  - should be defined as a constant in the model class.
# Usage:
# The model class should include the YamlModel concern after defining the Schema.
# The model class will have the following methods available:
#   - all: returns all records
#   - find(id): returns the record with the given id
#   - find_by(attribute, value): returns the first record with the given attribute value
#   - find_by!(attribute, value): same as find_by but raises ActiveRecord::RecordNotFound if not found
#   - where(attribute, value): returns all records with the given attribute value
#   - first(n): returns the first record or the first n records
#   - last(n): returns the last record or the last n records
module YamlModel
  extend ActiveSupport::Concern

  included do
    def self.load_data!
      raise 'Schema not defined' unless defined?(self::Schema) && self::Schema.is_a?(Struct)

      data = YAML.load_file(file_path)

      # ensure primary key is unique
      raise 'Multiple records with the same id' if data.map { |record| record[:id] }.uniq.size != data.size

      @model_data = data.map do |record|
        self::Schema.new(record)

      rescue ArgumentError => e
        raise "Malformed data in #{file_path}.\nRecord:\n#{record.inspect}\nMessage:\n#{e.message}"
      end
    end

    def self.file_path
      Rails.root.join('config', 'model_data', "#{file_name}.yml")
    end

    def self.file_name
      base_name = defined?(model_name) ? self.model_name.plural : self.itself.to_s.pluralize
      base_name.underscore
    end

    load_data!
  end

  class_methods do
    def all
      @model_data
    end

    def find(id)
      @model_data.find { |record| record[:id] == id }
    end

    def find_by(attribute, value)
      @model_data.find { |record| record[attribute] == value }
    end

    def find_by!(attribute, value)
      record = find_by(attribute, value)
      raise ActiveRecord::RecordNotFound unless record

      record
    end

    def where(attribute, value)
      @model_data.select { |record| record[attribute] == value }
    end

    def first(n = nil)
      n.present? ? @model_data.first(n) : @model_data.first
    end

    def last(n = nil)
      n.present? ? @model_data.last(n) : @model_data.last
    end
  end

end
