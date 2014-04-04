require "call_sp/version"
require "call_sp/stored_procedure"

module CallSp

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def procedure(name, options = {})

      proc_name = options[:as] || name

      self.class_eval(<<-EOM, __FILE__, __LINE__ + 1)
          def self.#{name}(params = [], options = {})
            options = #{options}.merge!(options)
            StoredProcedure.call_proc("#{proc_name}", params, options)
          end
      EOM

    end

  end
end
