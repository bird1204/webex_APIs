module Webex
  module User
    # comment
    class Action
      attr_accessor :meeting_key, :cancel_mail?, :back_url,
        :start_feature, :app_handle, :location, :parameter, :url, :document_location,
        :attendee_name, :attendee_mail, :phone, :password, :registration_id


      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes! :back_url
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

      def edit

      end

      def register

      end

      def schedule

      end

      def impromptu

      end

      private

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:MK] = meeting_key
        result[:BU] = back_url
        # delete
        result[:SM] = cancel_mail?
        # host
        result[:AS] = start_feature
        result[:AH] = app_handle
        result[:AL] = location
        result[:AP] = parameter
        result[:DL] = document_location
        result[:WL] = url
        # join
        result[:AN] = attendee_name
        result[:AE] = attendee_mail
        result[:CO] = phone
        result[:PW] = password
        result[:RID] = registration_id


        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
