require 'spec_helper'

describe Remitano::Offers do
  describe :my_offers, vcr: {cassette_name: 'remitano/my_offers/sell'} do
    subject { Remitano.offers.my_offers("sell") }
    its(:length) { should == 1 }
  end

  describe :update, vcr: {cassette_name: 'remitano/offers/update'} do
    it "change the offer" do
      Remitano.offers.update(2, price: 21800)
      offer = Remitano.offers.my_offers("sell").first
      offer[:price].should == 21800
    end
  end
end
