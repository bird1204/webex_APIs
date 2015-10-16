module Webex
  module Meeting
    # comment
    class Report
      include Webex
      attr_accessor :recording_topic, :specify_url, :agenda, :registration,
                    :destination_address_after_session, :description, :email_address,
                    :duration_hours, :duration_minutes, :month, :year, :presenter,
                    :file_access_password, :file_size, :recording_type, :view_download,
                    :back_url, :day
      # phones = {PhoneCountry: nil, PhoneArea: nil, PhoneNumber: nil, PhoneExt: nil}

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def create
        option_required! :recording_topic
        { params: generate_params(api_type: 'CR'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
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

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:RT] = recording_topic
        result[:UL] = specify_url
        result[:AG] = agenda
        result[:AR] = registration
        result[:DstURL] = destination_address_after_session
        result[:DS] = description
        result[:EM] = email_address
        result[:HR] = duration_hours
        result[:MI] = duration_minutes
        result[:MH] = month
        result[:DY] = day
        result[:YR] = year
        result[:PT] = presenter
        result[:PW] = file_access_password
        result[:SZ] = file_size
        result[:TP] = recording_type
        result[:VD] = view_download
        result[:BU] = back_url
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
