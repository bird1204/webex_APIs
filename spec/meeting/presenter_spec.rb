require 'spec_helper'

describe Webex::Meeting::Presenter do
  API_URL = 'https://engsound.webex.com/engsound/m.php'
  CUSTOM_ATTRIBUTES = { meeting_key: 'fweofuw9873ri', email: 'fewjo@jfo.com' }
  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]add' do
    api_type = 'AP'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Presenter.new(CUSTOM_ATTRIBUTES.merge!(full_name: 'full_name')).add
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]add' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Presenter.new.add }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]delete' do
    api_type = 'DP'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Presenter.new(CUSTOM_ATTRIBUTES).delete
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end
end
