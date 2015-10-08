module Webex
  module User
    # comment
    class Activation
      attr_accessor :webex_id, :partner_id, :back_url

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes! :webex_id, :back_url
        option_required! :webex_id, :partner_id, :back_url
      end

      def activate
        { params: generate_params(api_type: 'AC'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def deactivate
        { params: generate_params(api_type: 'IN'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:WID] = webex_id
        result[:PID] = partner_id
        result[:BU] = back_url
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
