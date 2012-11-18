require "spec_helper"

describe Sandy::Area do
  let(:customers_affected) { 100 }
  let(:options) { {} }

  describe "#customers_affected" do
    subject { Sandy::Area.new(customers_affected, nil).customers_affected }
    it { should == customers_affected }
  end

  describe "#to_json" do
    subject { Sandy::Area.new(customers_affected, nil).to_json }
    it { should == {"name" => nil, 
                    "customers_affected" => customers_affected,
                    "parent" => nil, 
                    "total_customers" => nil,
                    "latitude" => nil,
                    "longitude" => nil, 
                    "estimated_recovery_time" => nil,
                    "children" => [] }.to_json }
  end
  
  context "with an area name" do
    let(:area_name) { "Battery Park" }
    describe "#name" do
      subject { Sandy::Area.new(customers_affected, area_name).name }
      it { should == area_name }
    end
  end

  context "with a region name" do
    describe "#parent_region" do
      subject { Sandy::Area.new(customers_affected, nil, { parent: "Manhattan" }).parent }
      it { should == "Manhattan" }
    end
  end

  context "with lat/lng" do
    subject { Sandy::Area.new(customers_affected, nil, { latitude: 70.5, longitude: -115.5 }) }
    its(:latitude) { should == 70.5 }
    its(:longitude) { should == -115.5 }
  end

  context "with lat/lng" do
    let(:etr) { Time.now + 600 }
    subject { Sandy::Area.new(customers_affected, nil, { estimated_recovery_time: etr }) }
    its(:estimated_recovery_time) { should == etr }
  end
end

