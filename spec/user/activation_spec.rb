require 'spec_helper'

describe Webex::User::Activation do
  API_URL = 'https://engsound.webex.com/engsound/p.php'
  CUSTOM_ATTRIBUTES = { webex_id: 'test', partner_id: 'partner_id' }

  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]activate' do
    api_type = 'AC'

    it '#api /p.php with custom set' do
      params = Webex::User::Activation.new(CUSTOM_ATTRIBUTES).activate
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]activate' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Activation.new }.to raise_error(Webex::MissingOption)
    end
  end


  context '[PARAMS]deactivate' do
    api_type = 'IN'

    it '#api /p.php with custom set' do
      params = Webex::User::Activation.new(CUSTOM_ATTRIBUTES).deactivate
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]deactivate' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Activation.new }.to raise_error(Webex::MissingOption)
    end
  end
end
