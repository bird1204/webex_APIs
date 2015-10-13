module Webex
  module Meeting
    # comment
    class Presenter
      attr_accessor :meeting_key, :back_url, :email, :full_name, :invitation,
                    :phones, :cancel_mail?
      # phones = {PhoneCountry: nil, PhoneArea: nil, PhoneNumber: nil, PhoneExt: nil}

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes! :back_url, :meeting_key, :email
        option_required! :back_url
      end

      def add
        option_required! :full_name
        { params: generate_params(api_type: 'AP'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def delete
        { params: generate_params(api_type: 'DP'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

      def phone_params
        result = {}
        result[:PC] = phones[:PhoneCountry]
        result[:PA] = phones[:PhoneArea]
        result[:PN] = phones[:PhoneNumber]
        result[:PE] = phones[:PhoneExt]
        result
      end

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:MK] = meeting_key
        result[:BU] = back_url
        result[:FN] = full_name
        result[:EM] = email
        if result[:AT] == 'AP'
          result[:EI] = invitation
          result.merge!(phone_params) if phones
        end
        result[:EC] = cancel_mail? if result[:AT] == 'DP'
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
