module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_arr = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}_history".to_sym) { instance_variable_get(var_arr) }

      define_method("#{name}=".to_sym) do |value|
        arr = instance_variable_get(var_arr) || [instance_variable_get(var_name)]
        arr << value
        instance_variable_set(var_name, value)
        instance_variable_set(var_arr, arr)
      end
    end
  end

  def strong_attr_accessor(name, input_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.instance_of?(input_class)
        instance_variable_set(var_name, value)
      else
        self.class.send(:raise, "Incorrect data type")
      end
      rescue RuntimeError => e
        puts e.message
    end
  end
end
