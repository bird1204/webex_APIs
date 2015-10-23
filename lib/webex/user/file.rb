module Webex
  module User
    # comment
    class File
      include Webex
      include Webex::User

      attr_accessor :file_name, :back_url, :current_directory

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def download
        option_required! :file_name
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'DF')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def list
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'LF')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:BU] = back_url
        result[:FN] = file_name if result[:AT] == 'DF'
        result[:CD] = current_directory if result[:AT] == 'LF'

        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
