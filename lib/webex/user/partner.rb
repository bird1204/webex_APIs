module Webex
  module User
    # comment
    class Partner
      include Webex
      include Webex::User
      attr_accessor :webex_id, :ticket, :password, :back_type, :back_url, :email,
                    :session, :first_name, :last_name, :new_password
      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :webex_id, :back_type, :back_url
      end

      def login
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'LI')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def logout
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'LO')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

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
