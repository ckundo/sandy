require 'spec_helper'

describe "a user in Manhattan without power" do
  let(:outage) { double(:outage, estimated_recovery_at: double) }
  let(:latitude) { 40.714623 }
  let(:longitude) { -74.006605 }

  describe "seeking estimated recovery time" do
    subject { Sandy::Report.new(latitude, longitude).estimated_recovery_at }

    it { should == recovery_at }
  end
end
