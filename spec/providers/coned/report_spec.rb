require "spec_helper"

describe Sandy::Provider::ConEd::Report, :vcr do
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

  describe "#areas" do
    subject { Sandy::Provider::ConEd::Report.new.areas }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end
end
