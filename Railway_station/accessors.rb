module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_arr = "@#{name}_arr".to_sym
      instance_variable_set(var_arr, [])
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        arr = instance_variable_get(var_arr)
        arr << instance_variable_get(var_name) if arr.empty?
        instance_variable_set(var_name, value)
        instance_variable_set(var_arr, arr)
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(var_arr) }
    end
  end

  def strong_attr_accessor(name, input_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if var_name.class == input_class
        instance_variable_set(var_name, value)
      else
        self.class.send(:raise, StandardError)
      end
    end
  end
end