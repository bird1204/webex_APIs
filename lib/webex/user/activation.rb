module Webex
  module User
    # comment
    class Activation
      include Webex
      include Webex::User
      attr_accessor :webex_id, :partner_id, :back_url

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :webex_id, :partner_id, :back_url
      end

      def activate
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'AC')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def deactivate
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'IN')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

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
