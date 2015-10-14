require 'spec_helper'

describe Webex::User::Report do
  api_url = 'https://engsound.webex.com/engsound/p.php'
  custom_attributes = { report_type: '0' }
  context '[PARAMS]display' do
    api_type = 'QR'

    it '#api /p.php with custom set' do
      params = Webex::User::Report.new(custom_attributes).display
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[ERROR]display' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Report.new.display }.to raise_error(Webex::MissingOption)
    end
  end
end
