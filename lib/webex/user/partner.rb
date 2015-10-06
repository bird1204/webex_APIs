require "webex/error/errors"
module Webex
  module User
    class Partner
      attr_accessor :webex_id, :ticket, :password, :back_type, :back_url, :email, :session, :first_name, :last_name, :new_password
      attr_reader :path
      PATH_URL = 'p.php'.freeze
      CONFIGURATION = Webex::Configuration

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        webex_id = CONFIGURATION.webex_id unless webex_id
        password = CONFIGURATION.password unless password
        @path = PATH_URL
        option_required! :webex_id
      end

      def login(overwrite_params = {})
        res = request PATH_URL, generate_params(overwrite_params.merge!(api_type: 'LI'))
        res.body
        # Hash[res.body.split('&').map! { |i| i.split('=') }]
      end

      def logout
        res = request PATH_URL, generate_params(overwrite_params.merge!(api_type: 'LO'))
        res.body
      end

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:WID] = overwrite_params[:webex_id] || webex_id
        result[:MU] = overwrite_params[:back_type] || back_type
        result[:BU] = overwrite_params[:back_url] || back_url

        if result[:AT] == 'LI'
          result[:TK] = overwrite_params[:ticket] || ticket
          result[:PW] = overwrite_params[:password] || password
          result[:EM] = overwrite_params[:email] || email
          result[:SK] = overwrite_params[:session] || session
          result[:FN] = overwrite_params[:first_name] || first_name
          result[:LN] = overwrite_params[:last_name] || last_name
          result[:NPW] = overwrite_params[:new_password] || new_password
        end
        
        result.delete_if { |k, v| v.nil? }
      end

      private

      def request(path, params = {})
        api_url = URI.join(CONFIGURATION.host_url + path)
        Net::HTTP.post_form api_url, params
      end

      def option_required!(*option_names)
        option_names.each do |option_name|
          raise MissingOption, %Q{option "#{option_name}" is required.} if send(option_name).nil?
        end
      end
    end
  end
end
