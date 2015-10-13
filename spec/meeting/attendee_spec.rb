require 'spec_helper'

describe Webex::Meeting::Attendee do
  API_URL = 'https://engsound.webex.com/engsound/m.php'
  CUSTOM_ATTRIBUTES = { meeting_key: 'fweofuw9873ri' }
  ATTENDEE_ATTRIBUTES = [{ FullName: 'FullName1', EmailAddress: 'nil', PhoneCountry: 'nil', PhoneArea: 'nil', PhoneLocal: 'nil', PhoneExt: 'nil', TimeZone: 'nil', Language: 'nil', Locale: 'nil', AddToAddressBook: 'nil' },
                         { FullName: 'FullName2', EmailAddress: '123321', PhoneCountry: '123321', PhoneArea: '123321', PhoneLocal: '123321', PhoneExt: '123321', TimeZone: '123321', Language: '123321', Locale: '123321', AddToAddressBook: '123321' },
                         { FullName: 'FullName3', EmailAddress: 'fewwef', PhoneCountry: 'fewwef', PhoneArea: 'fewwef', PhoneLocal: 'fewwef', PhoneExt: 'fewwef', TimeZone: 'fewwef', Language: 'fewwef', Locale: 'fewwef', AddToAddressBook: 'fewwef' }]
  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]add' do
    api_type = 'AA'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Attendee.new(CUSTOM_ATTRIBUTES.merge!(attendees: ATTENDEE_ATTRIBUTES)).add
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]add' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Attendee.new.add }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]delete' do
    api_type = 'DA'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Attendee.new(CUSTOM_ATTRIBUTES.merge!(email: 'fjweoif.com.efew')).delete
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]delete' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Attendee.new.delete }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]detail' do
    api_type = 'MD'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Attendee.new(CUSTOM_ATTRIBUTES).detail
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR]detail' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Attendee.new.detail }.to raise_error(Webex::MissingOption)
    end
  end  
end
