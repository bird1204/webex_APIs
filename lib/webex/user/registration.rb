module Webex
  module User
    # comment
    class Registration
      attr_accessor :webex_id, :first_name, :last_name, :email, :password, :partner_id, :back_url,
                    # optional attributes
                    :address_1, :address_2, :city, :state, :zip_code, :country, :office_phones, :fax_phones,
                    :computer, :storage, :admin, :web_ex_type, :partner_link, :portal, :meeting_type,
                    :supports, :tracking_codes, :time_zone, :one_click, :password_change, :tsp_bridges,
                    :new_webex_id, :new_password

      # office_phones = {OPhoneCountry: nil, OPhoneArea: nil, OPhoneLocal: nil, OPhoneExt: nil}
      # fax_phones = {FPhoneCountry: nil, FPhoneArea: nil, FPhoneLocal: nil, FPhoneExt: nil}
      # supports = { SupportRecordingEdit: nil, SupportFileFolder: nil, SupportMyContacts: nil,
      #              SupportMyProfile: nil, SupportMyMeetings: nil, SupportEndUserReport: nil,
      #              SupportAccessAnywhere: nil, SupportMyRecordings: nil, SupportEventDocuments: nil,
      #              SupportPersonalLobby: nil}
      # tracking_codes = [nil, nil, nil]
      # tsp_bridges: [{CreateAccount: nil, TollFreeCallIn: nil, TollCallIn1: nil, ParticipantAccessCode: nil, SubscribeAccessCode: nil},
      #               {CreateAccount: nil, TollFreeCallIn: nil, TollCallIn1: nil, ParticipantAccessCode: nil, SubscribeAccessCode: nil},
      #               {CreateAccount: nil, TollFreeCallIn: nil, TollCallIn1: nil, ParticipantAccessCode: nil, SubscribeAccessCode: nil}]
      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes! :webex_id, :password, :back_url
        option_required! :webex_id, :password, :partner_id
      end

      def sign_up(condition={})
        option_required! :webex_id, :first_name, :last_name, :email, :password, :partner_id
        { params: generate_params(api_type: 'SU'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def edit(condition={})
        option_required! :webex_id, :password, :partner_id
        { params: generate_params(api_type: 'EU'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

      def tracking_code_hash
        attribute_length!(10, tracking_codes)
        hash = {}
        tracking_codes.each_with_index do |code, index|
          hash.merge!("TC#{index + 1}".to_sym => code)
        end
        hash
      end

      def supports_hash
        hash = {}
        hash[:RP] = supports[:SupportRecordingEdit]
        hash[:FL] = supports[:SupportFileFolder]
        hash[:AB] = supports[:SupportMyContacts]
        hash[:PF] = supports[:SupportMyProfile]
        hash[:MM] = supports[:SupportMyMeetings]
        hash[:MR] = supports[:SupportEndUserReport]
        hash[:AA] = supports[:SupportAccessAnywhere]
        hash[:RC] = supports[:SupportMyRecordings]
        hash[:RE] = supports[:SupportEventDocuments]
        hash[:LB] = supports[:SupportPersonalLobby]
        hash
      end

      def tsp_bridges_hash
        attribute_length!(3, tsp_bridges)
        index_table = { CreateAccount: :CB, TollFreeCallIn: :FI, TollCallIn1: :TI, ParticipantAccessCode: :PA, SubscribeAccessCode: :SA }
        hash = {}
        tsp_bridges.each_with_index do |bridge, index|
          bridge.each do |key, value|
            hash.merge!(:"#{index_table[key]}#{index + 1}" => value)
          end
        end
        hash
      end

      def merge_hash!(overwrite_params)
        overwrite_params.merge!(office_phones) if office_phones
        overwrite_params.merge!(fax_phones) if fax_phones
        overwrite_params.merge!(supports_hash) if supports
        overwrite_params.merge!(tracking_code_hash) if tracking_codes
        overwrite_params.merge!(tsp_bridges_hash) if overwrite_params[:AT] == 'EU' && tsp_bridges 
        overwrite_params.delete_if { |k, v| v.nil? }
      end

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:PW] = password
        result[:PID] = partner_id
        result[:WID] = webex_id
        result[:Address1] = address_1
        result[:Address2] = address_2
        result[:City] = city
        result[:State] = state
        result[:ZipCode] = zip_code
        result[:Country] = country
        result[:AC] = computer
        result[:AS] = storage
        result[:LA] = admin
        result[:MW] = web_ex_type
        result[:PL] = partner_link
        result[:PT] = portal
        result[:MT] = meeting_type
        result[:TimeZone] = time_zone
        result[:BU] = back_url
        result[:OC] = one_click

        if result[:AT] == 'SU'
          result[:FN] = first_name
          result[:LN] = last_name
          result[:EM] = email
          result[:ForceChangeUserPwd] = password_change
        end

        if result[:AT] == 'EU'
          result[:NFN] = first_name
          result[:NLN] = last_name
          result[:NEM] = email
          result[:NPW] = new_password
          result[:NWID] = new_webex_id
        end
        merge_hash!(result)
      end

      def attribute_length!(length, attribute)
        raise LengthError, %Q{option "#{attribute}" is too long.} if attribute.size > length
      end
    end
  end
end
