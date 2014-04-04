class StoredProcedure

  def self.call_proc(proc_name, params = [], options = {})
    params.delete_if { |p| p.nil? }

    select = options[:select].present? ? options[:select].map {|k, v| "#{k} AS #{v}" }.join(', ') : '*'
    schema = options[:schema] || 'public'
    conditions = options[:conditions] || []
    where = options[:conditions].present? ? " WHERE #{options[:conditions].first} " : ''
    order = options[:order].present? ? " ORDER BY #{options[:order]} " : ''

    sql = "SELECT #{select} FROM #{schema}.#{proc_name}(#{Array.new(params.count) { '?' }.join(', ')})#{where}#{order}"

    conditions.shift
    params.push(*conditions)

    mode = options[:mode] || :fetch_sp
    case mode
      when :fetch_sp_val
        self.fetch_sp_val(sql, *params)
      when :execute_sp
        self.execute_sp(sql, *params)
      when :fetch_sp
        self.fetch_sp(sql, *params)
      else
        raise 'Undefined mode'
    end

  end

  def self.execute_sp(sql, *bindings)
    perform_sp(:execute, sql, *bindings)
  end

  def self.fetch_sp(sql, *bindings)
    perform_sp(:select_all, sql, *bindings)
  end

  def self.fetch_sp_val(sql, *bindings)
    perform_sp(:select_value, sql, *bindings)
  end

  protected
    def self.perform_sp(method, sql, *bindings)
      if bindings.any?
        sql = ActiveRecord::Base.send(:sanitize_sql_array, bindings.unshift(sql))
      end
      ActiveRecord::Base.connection.send(method, sql)
    end



end