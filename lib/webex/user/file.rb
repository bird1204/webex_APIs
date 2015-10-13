module Webex
  module User
    # comment
    class File
      attr_accessor :file_name, :back_url, :current_directory

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes! :back_url
        option_required! :back_url
      end

      def download
        option_required! :file_name
        { params: generate_params(api_type: 'DF'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def list
        { params: generate_params(api_type: 'LF'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

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
