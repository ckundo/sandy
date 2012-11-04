require "spec_helper"

describe Sandy::Provider::LIPA::Report do
  describe ".initialize" do
    context "with an empty response" do
      before { HTTParty.stub(:get).and_return("") }
      it "raises an informative error" do
        expect { Sandy::Provider::LIPA::Report.new }.to raise_error(LoadError, "ConEd reponse was not recognizable.")
      end
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
