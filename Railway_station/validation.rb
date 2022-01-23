module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    include MessageSystem
    def validate(name, type, *_args)
      var_name = "@#{name}".to_sym
      errors = '@errors'.to_sym
      define_method('errors') { instance_variable_get(errors) }
      define_method("validate_#{type}") do
        var = instance_variable_get(var_name)
        err = instance_variable_get(errors) || []
        error = eval(ERRORS_ARRAY[type])
        err << error
        instance_variable_set(errors, err)
      end
    end

    ERRORS_ARRAY = {
      presence: 'ERRORS[:not_exist] if var.nil? || var.empty?',
      format: 'ERRORS[:incorr_format] if var !~ args[0]',
      type: 'ERRORS[:no_match_class] unless var.instance_of?(args[0])',
      length: 'ERRORS[:length] unless var.length == args[0]'
    }.freeze
  end

  module InstanceMethods
    def validate!
      methods.grep(/^validate_/) { |m| send(m) }
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
