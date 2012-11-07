module Sandy::Provider
  module ConEd
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(coned_url))
        area_hash = raw_report.fetch("file_data")["curr_custs_aff"]["areas"].first["areas"]
        
        @areas = recursive_fetch_areas(
          area_hash, ->(area) { area.fetch("areas", nil) } 
        )

      rescue
        raise LoadError, "ConEd response was not recognizable."
      end
    end
  end
end
