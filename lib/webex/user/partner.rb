module Webex
  module User
    # comment
    class Partner
      include Webex
      attr_accessor :webex_id, :ticket, :password, :back_type, :back_url, :email,
                    :session, :first_name, :last_name, :new_password
      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :webex_id, :back_type, :back_url
      end

      def login
        { params: generate_params(api_type: 'LI'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def logout
        { params: generate_params(api_type: 'LO'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      private

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:WID] = webex_id
        result[:MU] = back_type
        result[:BU] = back_url

        if result[:AT] == 'LI'
          result[:TK] = ticket
          result[:PW] = password
          result[:EM] = email
          result[:SK] = session
          result[:FN] = first_name
          result[:LN] = last_name
          result[:NPW] = new_password
        end
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
