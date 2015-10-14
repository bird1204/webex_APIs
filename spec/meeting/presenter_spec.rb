require 'spec_helper'

describe Webex::Meeting::Presenter do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = { meeting_key: 'fweofuw9873ri', email: 'fewjo@jfo.com' }

  context '[PARAMS]add' do
    api_type = 'AP'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Presenter.new(custom_attributes.merge!(full_name: 'full_name')).add
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[ERROR]add' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Presenter.new.add }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]delete' do
    api_type = 'DP'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Presenter.new(custom_attributes).delete
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end
end
