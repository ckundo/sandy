# Sandy

Rubygem for consuming power outage data for the Greater New York area. Currently supports ConEd and LIPA.
[![Build Status](https://secure.travis-ci.org/ckundo/sandy.png)](https://travis-ci.org/ckundo/sandy)

## Usage

### Providers
    
    Sandy::Provider::LIPA::Report.new
    Sandy::Provider::ConEd::Report.new

### Areas

    Area#name
    Area#customers_affected
    Area#region
    Area#latitude
    Area#longitude
    Area#total_customers
    Area#estimated_recovery_time

### Example

    report = Sandy::Provider::LIPA::Report.new

    regions = report.regions
    regions.each do |region|
      puts "#{region.name}, #{region.customers_affected}"
    end

# returns => 

    Bronx, 28644
    Brooklyn, 37016
    Manhattan, 226225
    Queens, 85057
    Staten Island, 58043
    Westchester, 123571

Neighborhoods are a subset of regions:

    neighborhoods = report.neighborhoods
    neighborhoods.each do |neighborhood|
      puts "#{neighborhood.name} (#{neighborhood.latitude}, #{neighborhood.longitude}) #{neighborhood.customers_affected} out of #{neighborhood.total_customers}"
    end

=> 

    Central Bronx (40.82, -73.86) 26 out of 44452
    Fordham (40.86, -73.9) 164 out of 114772
    Northeast Bronx (40.87, -73.82) 13139 out of 79942
    Riverdale (40.89, -73.9) 3801 out of 34772
    Southeast Bronx (40.83, -73.82) 5919 out of 89736
    ...

### A note on Polling

The ConEd outage feed is only updated every 15 minutes. Repeated polling won't get you new results.

## Installation

Add this line to your application's Gemfile:

    gem 'sandy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sandy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
