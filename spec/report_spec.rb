require 'spec_helper'

describe Sandy::Report do
  describe ".initialize" do
    subject { Sandy::Report.new(latitude, longitude, [provider]) }

    let(:latitude) { 40.714623 }
    let(:longitude) { -74.006605 }

    context "with customer outages" do
      let(:providers) { [provider] }
      let(:provider) { double(:provider, outages: [ double ]) }
      before do
        Sandy::ConEd.stub(:outages).and_return([double])
        Sandy::LIPA.stub(:outages).and_return([double])
      end
      
      it "has affected areas" do
        subject.affected_areas.should_not be_empty
      end
    end

    context "without customer outages" do
      before do
        Sandy::ConEd.stub(:outages).and_return([])
        Sandy::LIPA.stub(:outages).and_return([])
      end

      it "has no affected areas" do
        subject.affected_areas.should be_empty
      end
    end

    context "with a specified range"
    context "with a specified provider"
  end
end
