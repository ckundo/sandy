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

    def to_s
      @name
    end

    def to_json(*a)
      {"name" => @name, 
       "customers_affected" => @customers_affected,
       "parent" => @parent.to_s,
       "total_customers" => @total_customers,
       "latitude" => @latitude,
       "longitude" => @longitude, 
       "estimated_recovery_time" => @longitude,
       "children" => @children }.to_json
    end
  end
end
