$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'webex'

RSpec.configure do |config|
  config.before(:each) do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end
end
