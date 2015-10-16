module Webex
  module Meeting
    # comment
    class Action
      include Webex
      attr_accessor :meeting_key, :cancel_mail, :back_url,
        :start_feature, :app_handle, :location, :parameter, :url, :document_location,
        :attendee_name, :attendee_mail, :phone, :password, :registration_id
      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def delete
        option_required! :meeting_key
        { params: generate_params(api_type: 'DM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def host
        option_required! :meeting_key
        { params: generate_params(api_type: 'HM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def join
        option_required! :meeting_key
        { params: generate_params(api_type: 'JM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def list_meetings
        { params: generate_params(api_type: 'LM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def list_open_meetings
        { params: generate_params(api_type: 'OM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def schedule
        { params: generate_params(api_type: 'SM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

      def cancel_mail?
        cancel_mail
      end

      def tracking_code_hash
        attribute_length!(10, tracking_codes)
        hash = {}
        tracking_codes.each_with_index do |code, index|
          hash.merge!("TC#{index + 1}".to_sym => code)
        end
        hash
      end

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:MK] = meeting_key
        result[:BU] = back_url
        # delete
        if result[:AT] == 'DM'
          result[:SM] = cancel_mail?
        end
        # host
        if result[:AT] == 'HM'
          result[:AS] = start_feature
          result[:AH] = app_handle
          result[:AL] = location
          result[:AP] = parameter
          result[:DL] = document_location
          result[:WL] = url
        end
        # join
        if result[:AT] == 'JM'
          result[:AN] = attendee_name
          result[:AE] = attendee_mail
          result[:CO] = phone
          result[:PW] = password
          result[:RID] = registration_id
        end
        result.delete_if { |k, v| v.nil? }
      end

      def attribute_length!(length, attribute)
        raise LengthError, %Q{option "#{attribute}" is too long.} if attribute.size > length
      end
    end
  end
end
