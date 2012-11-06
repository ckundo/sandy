require 'tzinfo'
module Sandy::Provider
  module LIPA
    class Report
      include Sandy::Provider::StormCenter
      attr_reader :areas

      def initialize
        raw_report = HTTParty.get(lipa_url, format: :xml)
        area_hash = raw_report.fetch("root").fetch("curr_custs_aff")["areas"]["area"]["areas"].first[1]
        
        @areas = recursive_fetch_areas(
          area_hash, 
          ->(area) { area.fetch("areas", {}).fetch("area", nil) } 
        )

      rescue
        raise LoadError, "LIPA reponse was not recognizable."
      end
      
      private

      def lipa_url
        base_uri = "http://stormcenter.lipower.org"

        tz = TZInfo::Timezone.get('America/New_York')
        time = tz.now.to_i
        directory_url = "#{base_uri}/data/interval_generation_data/metadata.xml?timestamp=#{time}"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/data/interval_generation_data/#{directory}/data.xml?timestamp=#{time}"
      end

    end
  end
end
