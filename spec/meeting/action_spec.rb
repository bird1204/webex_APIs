require 'spec_helper'

describe Webex::Meeting::Action do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = { meeting_key: 'fweofuw9873ri' }

  context '[PARAMS]delete' do
    api_type = 'DM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).delete
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[PARAMS]list_open_meetings' do
    api_type = 'OM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).list_open_meetings
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[PARAMS]edit' do
    api_type = 'EM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).edit
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[PARAMS]schedule' do
    api_type = 'SM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Action.new(custom_attributes).schedule
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end
end
