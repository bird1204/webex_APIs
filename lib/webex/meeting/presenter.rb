module Webex
  module Meeting
    # comment
    class Presenter
      include Webex
      include Webex::Meeting
      attr_accessor :meeting_key, :back_url, :email, :full_name, :invitation,
                    :phones, :cancel_mail
      # phones = {PhoneCountry: nil, PhoneArea: nil, PhoneNumber: nil, PhoneExt: nil}

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def add
        option_required! :full_name
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'AP')
        p res.body
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def delete
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'DP')
        p res.body
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
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
      
      private

      def cancel_mail?
        cancel_mail
      end

      def phone_params
        result = {}
        result[:PC] = phones[:PhoneCountry]
        result[:PA] = phones[:PhoneArea]
        result[:PN] = phones[:PhoneNumber]
        result[:PE] = phones[:PhoneExt]
        result
      end
    end
  end
end
