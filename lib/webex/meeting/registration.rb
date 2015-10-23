module Webex
  module Meeting
    # comment
    class Registration
      include Webex
      include Webex::Meeting
      attr_accessor :meeting_key, :back_url, :first_name, :last_name, :email_address, :job_title,
        :computer_name, :address_1, :address_2, :city, :state, :zip_code, :country,
        :phone_number, :fax, :name_and_values, :text_box_contents, :check_box_contents,
        :radio_button_contents, :dropdown_list_selections

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def form
        option_required! :meeting_key
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'GF')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def register
        option_required! :meeting_key, :first_name, :last_name, :email_address, :job_title, :computer_name
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'RM')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end
      
      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:MK] = meeting_key
        result[:BU] = back_url

        if result[:AT] == 'RM'
          result[:FN] = first_name
          result[:LN] = last_name
          result[:EM] = email_address
          result[:JT] = job_title
          result[:CY] = computer_name
          result[:E1] = address_1
          result[:E2] = address_2
          result[:CT] = city
          result[:SA] = state
          result[:ZP] = zip_code
          result[:CI] = country
          result[:PH] = phone_number
          result[:FX] = fax
          result.merge!(name_and_value_params) if name_and_values
          result.merge!(tc_params)
        end
        result.delete_if { |k, v| v.nil? }
      end

      private

      def name_and_value_params
        attribute_length!(15, name_and_values)
        hash = {}
        name_and_values.each_with_index do |params, index|
          hash.merge!(:"name#{index + 1}" => params[:name])
          hash.merge!(:"value#{index + 1}" => params[:value])
        end
        hash
      end

      def tc_params
        attributes = [ text_box_contents, check_box_contents, radio_button_contents, dropdown_list_selections ]
        keys = ['TX', 'CB', 'RB', 'DL']
        hash = {}
        attributes.each_with_index do |params, index_of_keys|
          params.each_with_index do |value, index_of_value|
            hash.merge!(:"#{keys[index_of_keys]}#{index_of_value + 1}" => value)
          end if params
        end
        hash
      end

      def attribute_length!(length, attribute)
        raise LengthError, %Q{option "#{attribute}" is too long.} if attribute.size > length
      end
    end
  end
end
