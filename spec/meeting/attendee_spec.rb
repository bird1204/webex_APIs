require 'spec_helper'

describe Webex::Meeting::Attendee do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = { meeting_key: 'fweofuw9873ri' }
  attendee_attributes = [{ FullName: 'FullName1', EmailAddress: 'nil', PhoneCountry: 'nil', PhoneArea: 'nil', PhoneLocal: 'nil', PhoneExt: 'nil', TimeZone: 'nil', Language: 'nil', Locale: 'nil', AddToAddressBook: 'nil' },
                         { FullName: 'FullName2', EmailAddress: '123321', PhoneCountry: '123321', PhoneArea: '123321', PhoneLocal: '123321', PhoneExt: '123321', TimeZone: '123321', Language: '123321', Locale: '123321', AddToAddressBook: '123321' },
                         { FullName: 'FullName3', EmailAddress: 'fewwef', PhoneCountry: 'fewwef', PhoneArea: 'fewwef', PhoneLocal: 'fewwef', PhoneExt: 'fewwef', TimeZone: 'fewwef', Language: 'fewwef', Locale: 'fewwef', AddToAddressBook: 'fewwef' }]

  context '[PARAMS]add' do
    api_type = 'AA'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Attendee.new(custom_attributes.merge!(attendees: attendee_attributes)).add
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      params = Webex::Meeting::Attendee.new(custom_attributes.merge!(email: 'fjweoif.com.efew')).delete
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
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
      params = Webex::Meeting::Attendee.new(custom_attributes).detail
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq api_url
    end
  end

  context '[ERROR]detail' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Attendee.new.detail }.to raise_error(Webex::MissingOption)
    end
  end  
end
