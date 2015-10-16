require 'spec_helper'

describe Webex::Meeting::Report do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = { recording_topic: 'fweofuw9873ri' }

  context '[PARAMS]add' do
    api_type = 'CR'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Report.new(custom_attributes).create
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[ERROR]add' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Report.new.create }.to raise_error(Webex::MissingOption)
    end
  end
end
