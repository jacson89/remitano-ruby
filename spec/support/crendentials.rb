RSpec.configure do |config|
  config.before(:each) do
    Remitano.configure do |config|
      config.key = ENV['REMITANO_KEY']
      config.secret = ENV['REMITANO_SECRET']
      config.authenticator_secret = ENV['REMITANO_AUTHENTICATOR_SECRET']
    end
  end
end
