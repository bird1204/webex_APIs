module Webex
  module Meeting
    # comment
    class Schedule
      include Webex
      attr_accessor :meeting_name, :meeting_type, :list_flag, :meeting_password, :password_filter_feature,
        :require_attendee_registration, :automatically_accept_registration, :attendee_information,
        :registration_password, :maxinum_registrations_allowed, :registration_close_year, :registration_close_month,
        :registration_close_date, :teleconference_configuration, :internet_phone, :tele_lines, :other_teleconferencing_description,
        :exclude_PW, :request_login, :tsp_account, :if_auto_play_presentation, :if_attendee_join_before_host,
        :how_many_minutes_before_event_starts, :if_note_taker, :note_taker_option, :time_zone,
        :duration, :number_of_attendees, :number_of_presenters, :tracking_codes,
        :year, :month, :date, :hour, :minute, :number_of_sessions, :until_year,
        :until_month, :until_day, :recurrence_type, :repeat_days, :always_repeat,
        :reminder_email, :meeting_email, :if_send_reminder_email, :time, :mobile_device_number,
        :charge_mode, :whole_information, :credit_card_type, :first_name, :last_name,
        :credit_card_number, :credit_card_expiration_month, :credit_card_expiration_year,
        :email_address, :company, :street, :city, :state, :zip_code, :country_code,
        :phone_number, :future_use, :first_four_digits, :last_four_digits,
        :agenda, :attendee_features, :meeting_features, :description, :meeting_description,
        :display_message, :meeting_greeting, :if_request_attendee_to_check_rich_media_plays,
        :if_send_a_confirmation_email_to_the_host, :auto_delete_after_after_end,
        :callout_phone_number, :host_web_ex_id, :if_user_hands_on_lab,
        :lab_name, :number_of_computers, :invitation_email, :back_url, :document_location,
        :auto_start_feature, :app_location, :windows_app_handle, :url, :app_parameter

      def initialize(attributes = {})
        attributes.each { |k, v| send("#{k}=", v) }
        env_attributes!
        option_required! :back_url
      end

      def edit
        { params: generate_params(api_type: 'EM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def schedule
        { params: generate_params(api_type: 'SM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end

      def impromptu
        { params: generate_params(api_type: 'IM'),
          url: URI.join(CONFIGURATION.host_url + PATH_URL) }
      end


      private

      def generate_params(overwrite_params = {})
        result = {}
        result[:AT] = overwrite_params[:api_type]
        result[:BU] = back_url
        result[:MN] = meeting_name
        result[:MT] = meeting_type
        result[:LF] = list_flag
        result[:PW] = meeting_password
        result[:PR] = password_filter_feature
        result[:AR] = require_attendee_registration
        result[:AQ] = automatically_accept_registration
        result[:AI] = attendee_information
        result[:RPW] = registration_password # TC
        result[:NR] = maxinum_registrations_allowed # TC
        result[:RCY] = registration_close_year # TC
        result[:RCM] = registration_close_month # TC
        result[:RCD] = registration_close_date # TC
        result[:TC] = teleconference_configuration
        result[:IP] = internet_phone
        result[:TL] = tele_lines
        result[:TD] = other_teleconferencing_description
        result[:ExcludePW] = exclude_PW
        result[:RequestALogin] = request_login
        result[:TA] = tsp_account # MC 6.0
        result[:APP] = if_auto_play_presentation # MC 6.0
        result[:APPD] = document_location # MC 6.0
        result[:AJ] = if_attendee_join_before_host # MC 6.0
        result[:AJMI] = how_many_minutes_before_event_starts # MC 6.0
        result[:NT] = if_note_taker # MC 6.0
        result[:NTOP] = note_taker_option # MC 6.0
        result[:TZ] = time_zone
        result[:DU] = duration
        result[:NA] = number_of_attendees
        result[:NP] = number_of_presenters # TC
        result.merge!(tracking_code_hash) if tracking_codes
        result[:YE] = year
        result[:MO] = month
        result[:DA] = date
        result[:HO] = hour
        result[:MI] = minute
        result[:NS] = number_of_sessions # TC
        result[:UntilYE] = until_year
        result[:UntilMO] = until_month
        result[:UntilDA] = until_day
        result[:TY] = recurrence_type # TC
        result[:RO] = recurrence_type # MC
        result[:Days] = repeat_days
        result[:Always] = always_repeat # MC
        result[:Email] = reminder_email
        result[:ME] = meeting_email # MC
        result[:BM] = if_send_reminder_email # MC
        result[:ReminderTime] = time
        result[:MobileDN] = mobile_device_number # MC
        result[:CM] = charge_mode
        result[:WI] = whole_information
        result[:CT] = credit_card_type
        result[:FN] = first_name
        result[:LN] = last_name # MC
        result[:LA] = last_name # TC
        result[:CN] = credit_card_number
        result[:EM] = credit_card_expiration_month
        result[:EY] = credit_card_expiration_year
        result[:ML] = email_address
        result[:CP] = company
        result[:SR] = street
        result[:CI] = city
        result[:ST] = state
        result[:ZP] = zip_code
        result[:CY] = country_code
        result[:PO] = phone_number
        result[:LU] = future_use
        result[:F4] = first_four_digits
        result[:L4] = last_four_digits
        result[:AG] = agenda
        result[:AF] = attendee_features
        result[:MF] = meeting_features
        result[:DS] = description # TC
        result[:MD] = meeting_description # MC
        result[:PM] = display_message
        result[:MG] = meeting_greeting
        result[:TA] = tsp_account # TC
        result[:QK] = if_request_attendee_to_check_rich_media_plays # MC
        result[:CE] = if_send_a_confirmation_email_to_the_host # MC
        result[:AutoDeleteAfterEnd] = auto_delete_after_after_end # MC
        result[:CO] = callout_phone_number
        result[:HI] = host_web_ex_id
        result[:HL] = if_user_hands_on_lab # TC
        result[:LN] = lab_name # TC
        result[:NC] = number_of_computers # TC
        result[:VE] = invitation_email
        if result[:AT] == 'IM'
          result[:AS] = auto_start_feature
          result[:DL] = document_location
          result[:AL] = app_location
          result[:AH] = windows_app_handle
          result[:WL] = url
          result[:AP] = app_parameter
        end
        result.delete_if { |k, v| v.nil? }
      end
    end
  end
end
