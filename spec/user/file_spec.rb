require 'spec_helper'

describe Webex::User::File do
  API_URL = 'https://engsound.webex.com/engsound/p.php'
  CUSTOM_ATTRIBUTES = { back_url: 'localhost:4567' }

  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]download' do
    api_type = 'DF'

    it '#api /p.php with custom set' do
      params = Webex::User::File.new(CUSTOM_ATTRIBUTES.merge!(file_name: 'xxx')).download
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]download' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::File.new.download }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]list' do
    api_type = 'LF'

    it '#api /p.php with custom set' do
      params = Webex::User::File.new(CUSTOM_ATTRIBUTES).list
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end
end
