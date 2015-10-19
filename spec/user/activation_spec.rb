require 'spec_helper'

describe Webex::User::Activation do
  custom_attributes = { webex_id: 'test', partner_id: 'partner_id' }

  context '[PARAMS]activate' do
    api_type = 'AC'

    it '#api /p.php with custom set' do
      params = Webex::User::Activation.new(custom_attributes).activate

      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'PartnerIDError'
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
      params = Webex::User::Activation.new(custom_attributes).deactivate

      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'PartnerIDError'
    end
  end

  context '[ERROR]deactivate' do
    it '#api /p.php with option_missing' do
      expect { Webex::User::Activation.new }.to raise_error(Webex::MissingOption)
    end
  end
end
