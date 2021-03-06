require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'rest_client'
require 'hmac-sha2'
require 'hashie'
require 'rotp'

Dir[File.expand_path("../remitano/**/*.rb", __FILE__)].each { |f| require f }

String.send(:include, ActiveSupport::Inflector)

module Remitano
  class AuthenticatorNotConfigured < StandardError; end

  def self.default_config
    @default_config ||= Remitano::Config.new
  end

  class Config
    # API Key
    attr_accessor :key
    # Remitano secret
    attr_accessor :secret
    attr_accessor :authenticator_secret
    attr_accessor :verbose

    def authenticator_token
      ROTP::TOTP.new(authenticator_secret).now
    end

    def net
      @net ||= Remitano::Net.new(config: self)
    end

    def action_confirmations
      @action_confirmations ||= Remitano::ActionConfirmations.new(config: self)
    end

    def coin_accounts(coin)
      @coin_accounts ||= {}
      @coin_accounts[coin] ||= Remitano::CoinAccounts.new(coin, config: self)
    end

    def offers(coin)
      @offers ||= {}
      @offers[coin] ||= Remitano::Offers.new(coin, config: self)
    end

    def trades(coin)
      @trades ||= {}
      @trades[coin] ||= Remitano::Trades.new(coin, config: self)
    end

    def coin_withdrawals(coin)
      @coin_withdrawals ||= Remitano::CoinWithdrawals.new(coin, config: self)
    end

    def orders
      @orders ||= Remitano::Orders.new(config: self)
    end

    def configure
      yield self
      self
    end
  end
end
