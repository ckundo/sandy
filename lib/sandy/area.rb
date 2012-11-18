module Sandy
  class Area
    attr_reader :name, 
      :parent,
      :children,
      :customers_affected, 
      :latitude, 
      :longitude, 
      :total_customers,
      :estimated_recovery_time

    def initialize(customers_affected, location, options = {})
      @name = location
      @customers_affected = customers_affected
      @parent = options[:parent]
      @total_customers = options[:total_customers]
      @latitude = options[:latitude]
      @longitude = options[:longitude]
      @estimated_recovery_time = options[:estimated_recovery_time]
      @children = options[:children] || []
    end

    def to_json(*a)
      hash = {}
      self.instance_variables.each do |var|
        hash[var[1..-1]] = self.instance_variable_get var
      end
      hash.to_json
    end
  end
end
