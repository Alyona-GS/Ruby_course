module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    include MessageSystem

    def validate(name, type, *args)
      var_name = "@#{name}".to_sym
      errors = '@errors'.to_sym
      define_method('errors') { instance_variable_get(errors) }
      define_method("validate_#{type}") do
        obj = instance_variable_get(var_name)
        err = instance_variable_get(errors) || []
        error = eval(ERR_EXC[type])
        err << error
        instance_variable_set(errors, err)
      end
    end
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
