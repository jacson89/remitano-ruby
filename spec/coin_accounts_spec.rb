require 'spec_helper'

describe Remitano::CoinAccounts do
  describe :me, vcr: {cassette_name: 'remitano/coin_accounts/me'} do
    subject { Remitano.default_config.coin_accounts("btc") }
    it "returns my btc coin account" do
      result = subject.me
      expect(result.main.address).to eq("1NHy9krGCkkyNswx4Zu1MzxKRmnJ7j8W7c")
    end
  end
end
