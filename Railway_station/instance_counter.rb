module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @@counter
    end
  end

  module InstanceMethods
    
    @@counter = 0

    private

    def register_instances
      @@counter += 1
    end
  end
end