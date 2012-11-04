require "spec_helper"

describe Sandy::Provider::ConEd::Report do
  describe ".initialize" do
    context "with no response" do
      it "raises an error" do
      end
    end
    context "with an empty response" do
      it "raises an error" do
      end
    end
  end

  describe "#regions" do
    subject { Sandy::Provider::ConEd::Report.new.regions }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end

  describe "#neighborhoods" do
    subject { Sandy::Provider::ConEd::Report.new.neighborhoods }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end
end
