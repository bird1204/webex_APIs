require 'spec_helper'

describe Webex::Meeting::Schedule do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = {auto_start_feature: 'AutoStartFeature'}

  context '[PARAMS]edit' do
    api_type = 'EM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).edit
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end

  context '[PARAMS]schedule' do
    api_type = 'SM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).schedule
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end

  context '[PARAMS]impromptu' do
    api_type = 'IM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).impromptu
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end
end
