require "spec_helper"

describe Sandy::Provider::LIPA::Report do
  describe ".initialize" do
    context "with no response" do
      xit "raises an error" 
    end
    context "with an empty response" do
      xit "raises an error"
    end
  end

  describe "#regions" do
    subject { Sandy::Provider::LIPA::Report.new.regions }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end

  describe "#neighborhoods" do
    subject { Sandy::Provider::LIPA::Report.new.neighborhoods }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end
end
