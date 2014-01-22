require 'spec_helper'

module Guara
  describe Geo do

    subject(:geo) { Guara::Geo.new(lat: -3.2232432, long: -38.00980989)}


    it { should respond_to(:lat) }
    it { should respond_to(:long) }
    let(:geo1) { Factory :geo }
    let(:geo2) { Factory :geo }



    context ".close_to" do
      before { @postitions = [geo1, geo2] }
      geos = Guara::Geo.close_to(-3, -38).load
      geos.size.should eq(@postitions.size)
      geos.should include(@postitions.first)
    end
  end
end
