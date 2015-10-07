require 'spec_helper'
describe Webex::User::Registration do
  API_URL = 'https://engsound.webex.com/engsound/p.php'
  before :each do
    ENV['WEBEX_SITE_NAME'] = 'engsound'
    ENV['WEBEX_WEBEX_ID'] = 'test1118'
    ENV['WEBEX_PASSWORD'] = 'yeh1118'
    ENV['WEBEX_SITE_ID'] = '358562'
    ENV['WEBEX_BACK_TYPE'] = 'GoBack'
    ENV['WEBEX_BACK_URL'] = 'localhost:4567'
  end

  context '[PARAMS]sign_up' do
    api_type = 'SU'
    attributes = { webex_id: 'test', password: 'yeh', email: 'bird1204@gmail.com', partner_id: 'test12312', first_name: 'first', last_name: 'last' }

    it '#api /p.php with minimum SUCCESS set' do
      params = Webex::User::Registration.new(attributes).sign_up
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with add_phone SUCCESS set' do
      attributes.merge!(office_phones: {OPhoneCountry: 123123, OPhoneArea: 123213, OPhone: 12321, OfficePhExt: 12312})
      attributes.merge!(office_phones: {FPhoneCountry: 21321, FPhoneArea: 123, FPhoneLocal: 123, FPhoneExt: 123})
      params = Webex::User::Registration.new(attributes).sign_up
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with add support SUCCESS set' do
      attributes.merge!(supports: { SupportRecordingEdit: 21351, SupportFileFolder: 442, SupportMyContacts: 112,
                                    SupportMyProfile: 21351, SupportMyMeetings: 442, SupportEndUserReport: 112,
                                    SupportAccessAnywhere: 21351, SupportMyRecordings: 442, SupportEventDocuments: 112,
                                    SupportPersonalLobby: 21351})
      params = Webex::User::Registration.new(attributes).sign_up
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with add tracking_code SUCCESS set' do
      attributes.merge!(tracking_codes: [555, 666, 222, 123, 5325, 6734, 6241])
      params = Webex::User::Registration.new(attributes).sign_up
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR] sign_up' do
    it '#api /p.php with add tracking_code FAILED set' do
      attributes = { webex_id: 'test', password: 'yeh', email: 'bird1204@gmail.com', partner_id: 'test12312', first_name: 'first', last_name: 'last' }
      attributes.merge!(tracking_codes: [555, 666, 222, 123, 5325, 6734, 6241, 12312, 455, 64326, 8456523, 654, 35235, 523, 5125])
      registration = Webex::User::Registration.new(attributes)
      expect { registration.sign_up }.to raise_error(Webex::LengthError)
    end

    it '#api /p.php with FAILED set' do
      attributes = { webex_id: 'test', email: 'bird1204@gmail.com', partner_id: 'test12312', first_name: 'first'}
      registration = Webex::User::Registration.new(attributes)
      expect { registration.sign_up }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]edit' do
    api_type = 'EU'
    attributes = { webex_id: 'test', password: 'yeh', partner_id: 'test12312'}
    it '#api /p.php with minimum SUCCESS set' do
      attributes = { webex_id: 'test', password: 'yeh', partner_id: 'test12312'}
      params = Webex::User::Registration.new(attributes).edit
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end

    it '#api /p.php with TSP SUCCESS set' do
      attributes.merge!(tsp_bridges: [{CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'},
                    {CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'},
                    {CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'}])
      params = Webex::User::Registration.new(attributes).edit
      p params
      expect(params.keys).to match_array [:params, :url]
      expect(params[:params][:AT]).to eq api_type
      expect(params[:url].to_s).to eq API_URL
    end
  end

  context '[ERROR] edit' do
    it '#api /p.php with add TSP FAILED set' do
      attributes = { webex_id: 'test', password: 'yeh', email: 'bird1204@gmail.com', partner_id: 'test12312', first_name: 'first', last_name: 'last' }
      attributes.merge!(tsp_bridges: [{CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'},
                    {CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'},
                    {CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'},
                    {CreateAccount: 'nil', TollFreeCallIn: 'nil', TollCallIn1: 'nil', ParticipantAccessCode: 'nil', SubscribeAccessCode: 'nil'}])
      registration = Webex::User::Registration.new(attributes)
      expect { registration.edit }.to raise_error(Webex::LengthError)
    end
  end
end
