require 'spec_helper'

describe Webex::User::Partner do
  API_URL = 'https://engsound.webex.com/engsound/p.php'
  CUSTOM_ATTRIBUTES = { webex_id: 'test', password: 'yeh',back_type: 'GoBack', back_url: 'localhost:4567', email: 'bird1204@gmail.com' }

  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context 'login' do
    api_type = 'LI'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(CUSTOM_ATTRIBUTES).login
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.login
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context 'logout' do
    api_type = 'LO'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(CUSTOM_ATTRIBUTES).logout
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.logout
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end
end