require 'spec_helper'

describe Webex::Meeting::Schedule do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = {auto_start_feature: 'AutoStartFeature'}

  context '[PARAMS]edit' do
    api_type = 'EM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).edit
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[PARAMS]schedule' do
    api_type = 'SM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).schedule
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[PARAMS]impromptu' do
    api_type = 'IM'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Schedule.new(custom_attributes).impromptu
      
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end
end
