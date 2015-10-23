module Webex
  module Meeting
    # comment
    class Attendee
      include Webex
      include Webex::Meeting
      attr_accessor :meeting_key, :back_url, :invitation, :attendees, :cancel_mail, :email

      # attendees: [{FullName: FullName1, EmailAddress: nil, PhoneCountry: nil, PhoneArea: nil, PhoneLocal: nil, PhoneExt: nil, TimeZone: nil, Language: nil, Locale: nil, AddToAddressBook: nil},
      #               {FullName: FullName1, EmailAddress: nil, PhoneCountry: nil, PhoneArea: nil, PhoneLocal: nil, PhoneExt: nil, TimeZone: nil, Language: nil, Locale: nil, AddToAddressBook: nil},
      #               {FullName: FullName1, EmailAddress: nil, PhoneCountry: nil, PhoneArea: nil, PhoneLocal: nil, PhoneExt: nil, TimeZone: nil, Language: nil, Locale: nil, AddToAddressBook: nil}]
      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url, :meeting_key
      end

      def add
        option_required! :attendees
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'AA')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def delete
        option_required! :email
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'DA')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end

      def detail
        option_required! :email
        res = Net::HTTP.post_form post_url, generate_params(api_type: 'MD')
        Hash[res.body.stringify_string.split('&').map! { |i| i.split('=') }]
      end
      
      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:MK] = meeting_key
        result[:BU] = back_url
        result[:EM] = email
        result[:EI] = invitation
        result.merge!(attendees_hash) if  result[:AT] == 'AA'
        result[:EC] = cancel_mail? if result[:AT] == 'DA'
        result.delete_if { |k, v| v.nil? }
      end

      private

      def cancel_mail?
        cancel_mail
      end

      def attendees_hash
        index_table ={FullName: :FN, EmailAddress: :EA, PhoneCountry: :PhoneCountry, PhoneArea: :PhoneArea, PhoneLocal: :PhoneLocal, PhoneExt: :PhoneExt, TimeZone: :TimeZone, Language: :Language, Locale: :Locale, AddToAddressBook: :AddToAddressBook}
        hash = {}
        attendees.each_with_index do |attendee, index|
          attendee.each do |key, value|
            hash.merge!(:"#{index_table[key]}#{index + 1}" => value)
          end
        end
        hash
      end
    end
  end
end
