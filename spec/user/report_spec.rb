require 'spec_helper'

describe Webex::User::Report do
  API_URL = 'https://engsound.webex.com/engsound/p.php'
  CUSTOM_ATTRIBUTES = { report_type: '0' }

  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]display' do
    api_type = 'QR'

    it '#api /p.php with custom set' do
      params = Webex::User::Report.new(CUSTOM_ATTRIBUTES).display
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]display' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Report.new.display }.to raise_error(Webex::MissingOption)
    end
  end
end
