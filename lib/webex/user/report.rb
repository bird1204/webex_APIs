module Webex
  module User
    # comment
    class Report
      include Webex
      include Webex::User
      attr_accessor :report_type, :back_url, :start_month, :start_year, :start_date, 
                    :end_month, :end_year, :end_date, :topic, :sort_result_by

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :report_type, :back_url
      end

      def display
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'QR')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      private

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:BU] = back_url
        result[:StartMO] = start_month
        result[:StartYE] = start_year
        result[:StartDA] = start_date
        result[:EndMO] = end_month
        result[:EndYE] = end_year
        result[:EndDA] = end_date
        result[:TC] = topic
        result[:SB] = sort_result_by
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
