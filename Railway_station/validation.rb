module Validation
  ERRORS = { not_exist: 'The variable does not exist',
             no_match_class: 'The type of data is invalid',
             incorr_format: 'The format of data is invalid' }

  ROUTE_FORMAT = /^[A-Z]{3}-[A-Z]{3}$/.freeze
  TRAIN_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i.freeze

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *args)
      case type
      when :presence
        error = ERRORS[:not_exist] if name.nil? || name.empty?

      when :format
        error = ERRORS[:incorr_format] if name !~ args[0]

      when :type
        error = ERRORS[:no_match_class] unless name.class == args[0]
      end
      error
    end
  end

  module InstanceMethods
    def validate!
      errors = []
      if self.class == Route
        errors << self.class.validate(name, :format, ROUTE_FORMAT)
        errors << self.class.validate(stations.compact, :presence)
        errors << "At least one station does not exist" unless stations.compact.length == 2
      end
      if self.class == Station
        errors << self.class.validate(name, :type, String)
      end
      if self.class == CargoTrain || self.class == PassengerTrain
        errors << self.class.validate(number, :format, TRAIN_FORMAT)
      end
      errors.compact!
      raise errors.join('; ') unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end