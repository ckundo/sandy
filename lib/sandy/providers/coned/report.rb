module Sandy::Provider
  module ConEd
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(coned_url))
        area_hash = raw_report.fetch("file_data")["curr_custs_aff"]["areas"].first["areas"]
        
        @areas = recursive_fetch_areas(
          area_hash, 
          ->(area) { area.fetch("areas", nil) } 
        )

      rescue
        raise LoadError, "ConEd response was not recognizable."
      end

      def to_json(*a)
        hash = {}
        { "areas" => @areas.map(&:to_json) }
      end

      private

      def coned_url
        base_uri = "http://apps.coned.com"
        directory_url = "#{base_uri}/stormcenter_external/stormcenter_externaldata/data/interval_generation_data/metadata.xml"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/stormcenter_external/stormcenter_externaldata/data/interval_generation_data/#{directory}/report.js"
      end

      def path
        File.dirname(__FILE__)
      end
    end
  end
end
