require 'spec_helper'

describe Webex::Configuration do
  context 'with all environment variables present' do
    before :each do
      ENV['WEBEX_SITE_NAME'] = 'engsound'
      ENV['WEBEX_WEBEX_ID'] = 'test1118'
      ENV['WEBEX_PASSWORD'] = 'yeh1118'
      ENV['WEBEX_SITE_ID'] = '358562'
      ENV['WEBEX_BACK_TYPE'] = 'GoBack'
      ENV['WEBEX_BACK_URL'] = 'localhost:4567'
    end

    it '#all environment variables present' do
      expect(Webex::Configuration.site_name).to eq 'engsound'
      expect(Webex::Configuration.webex_id).to eq 'test1118'
      expect(Webex::Configuration.password).to eq 'yeh1118'
      expect(Webex::Configuration.host_url).to eq 'https://engsound.webex.com/engsound/'
      expect(Webex::Configuration.back_type).to eq 'GoBack'
      expect(Webex::Configuration.back_url).to eq 'localhost:4567'
    end

  end
end
