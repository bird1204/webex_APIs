require 'spec_helper'

describe Webex::User::Report do
  custom_attributes = { report_type: '0' }
  context '[PARAMS]display' do
    api_type = 'QR'

    it '#api /p.php with custom set' do
      params = Webex::User::Report.new(custom_attributes).display
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'UnknownATCommand'
    end
  end

  context '[ERROR]display' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Report.new.display }.to raise_error(Webex::MissingOption)
    end
  end
end
