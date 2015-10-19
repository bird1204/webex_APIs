require 'spec_helper'

describe Webex::User::Partner do
  custom_attributes = { webex_id: 'test', password: 'yeh',back_type: 'GoBack', back_url: 'localhost:4567', email: 'bird1204@gmail.com' }

  context '[PARAMS]login' do
    api_type = 'LI'

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.login
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'SUCCESS'
    end
  end

  context '[ERROR]login' do
    api_type = 'LI'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(custom_attributes).login
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
    end
  end

  context '[PARAMS]logout' do
    api_type = 'LO'

    it '#api /p.php with custom set' do
      params = Webex::User::Partner.new(custom_attributes).logout
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'SUCCESS'
    end

    it '#api /p.php with ENV set' do
      params = Webex::User::Partner.new.logout
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'SUCCESS'
    end
  end
end
