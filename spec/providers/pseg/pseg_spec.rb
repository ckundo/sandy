require "spec_helper"

describe Sandy::Provider::PSEG::Report do
  describe ".initialize" do
    context "with an empty response" do
      before { HTTParty.stub(:get).and_return("") }
      it "raises an informative error" do
        expect { Sandy::Provider::PSEG::Report.new }.to raise_error(LoadError, "PSEG response was not recognizable.")
      end
    end
  end

  describe "#areas" do
    subject { Sandy::Provider::PSEG::Report.new.areas }
    it { should be_an_instance_of Array }
    it { should_not be_empty }
  end
end
