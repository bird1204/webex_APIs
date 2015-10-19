require 'spec_helper'

describe Webex::Meeting::Action do
  custom_attributes = { meeting_key: 'fweofuw9873ri' }

  context '[PARAMS]delete' do
    api_type = 'DM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).delete
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end

  context '[ERROR]delete' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Action.new.delete }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]host' do
    api_type = 'HM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).host
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end

  context '[ERROR]host' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Action.new.host }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]join' do
    api_type = 'JM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).join
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'InvalidDataFormat'
    end
  end

  context '[ERROR]join' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Action.new.join }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]list_meetings' do
    api_type = 'LM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).list_meetings

      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end

  context '[PARAMS]list_open_meetings' do

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).list_open_meetings
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'AccessDenied'
    end
  end
end
