require 'spec_helper'

describe Webex::Configuration do
  context 'with all environment variables present' do
    it '#all environment variables present' do
      expect(Webex::Configuration.site_name).to eq 'engsound'
      expect(Webex::Configuration.webex_id).to eq 'test1118'
      expect(Webex::Configuration.password).to eq 'yeh1118'
      expect(Webex::Configuration.host_url).to eq 'https://engsound.webex.com/engsound/'
      expect(Webex::Configuration.back_type).to eq 'GoBack'
      expect(Webex::Configuration.back_url).to eq 'localhost:4567'
    end
  end
end
