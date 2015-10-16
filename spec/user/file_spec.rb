require 'spec_helper'

describe Webex::User::File do
  api_url = 'https://engsound.webex.com/engsound/p.php'
  custom_attributes = { back_url: 'localhost:4567' }

  context '[PARAMS]download' do
    api_type = 'DF'

    it '#api /p.php with custom set' do
      params = Webex::User::File.new(custom_attributes.merge!(file_name: 'xxx')).download
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      params = Webex::User::File.new(custom_attributes).list
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end
end
