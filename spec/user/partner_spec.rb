require 'spec_helper'

describe Webex::User::Partner do
  api_url = 'https://engsound.webex.com/engsound/p.php'
  custom_attributes = { webex_id: 'test', password: 'yeh',back_type: 'GoBack', back_url: 'localhost:4567', email: 'bird1204@gmail.com' }

  context 'login' do
    api_type = 'LI'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(custom_attributes).login
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.login
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context 'logout' do
    api_type = 'LO'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(custom_attributes).logout
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.logout
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end
end