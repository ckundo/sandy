module Sandy::Provider
  module LIPA
    class Report
      attr_reader :regions, :neighborhoods

      def initialize
        raw_report = HTTParty.get(lipa_url, format: :xml)
        area_hash = raw_report.fetch("root").fetch("curr_custs_aff")["areas"]["area"]["areas"].first[1]
        @regions = regions_from_report(area_hash)
        @neighborhoods = neighborhoods_from_report(area_hash)
      end
      
      private

      def lipa_url
        base_uri = "http://stormcenter.lipower.org"

        #FIXME: verify timezone is in NYC zone
        time = Time.now.to_i
        directory_url = "#{base_uri}/data/interval_generation_data/metadata.xml?timestamp=#{time}"
        response = HTTParty.get(directory_url, format: :xml)
        directory = response.parsed_response.fetch("root").fetch("directory")
        "#{base_uri}/data/interval_generation_data/#{directory}/data.xml?timestamp=#{time}"
      end

      def regions_from_report(areas)
        areas.collect do |area|
          Sandy::Area.new(area.fetch("custs_out"), area.fetch("area_name"),
                          { estimated_recovery_time: area["etr"],
                            total_customers: area["total_custs"] })

        end
      end

      def neighborhoods_from_report(areas_hash)
        neighborhoods = []
        areas_hash.each do |region|
          region["areas"].each do |sub_region|
            sub_sub_regions = sub_region[1]
            sub_sub_regions.each do |sub_sub_region|
              begin
                hoods = sub_sub_region["areas"]["area"]
              rescue
                # FIXME: raise warning if any region is empty
                next
              end
              hoods.each do |hood|
                total = hood.fetch("total_custs").to_i
                affected = hood.fetch("custs_out").to_i
                name = hood.fetch("area_name")
                region = sub_sub_region.fetch("area_name")

                neighborhoods << Sandy::Area.new(affected, name, { region: region, total_customers: total})
              end
            end
          end
        end
        neighborhoods
      end
    end
  end
end
