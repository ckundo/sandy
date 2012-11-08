module Sandy::Provider
  module OrangeRockland
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = JSON.parse(HTTParty.get(orange_rockland_url))
        area_hash = raw_report.fetch("file_data")["curr_custs_aff"]["areas"].first["areas"]
        
        @areas = recursive_fetch_areas(
          area_hash, 
          ->(area) { area.fetch("areas", nil) } 
        )

      rescue
        raise LoadError, "OrangeRockland response was not recognizable."
      end

      private

      def orange_rockland_url
        base_uri = "http://apps.coned.com"
        directory_url = "#{base_uri}/stormcenter_external_oru/stormcenter_external_orudata/data/interval_generation_data/metadata.xml"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/stormcenter_external_oru/stormcenter_external_orudata/data/interval_generation_data/#{directory}/report.js"
      end

    end
  end
end
