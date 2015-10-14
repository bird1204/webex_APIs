module Webex
  module User
    # comment
    class Action
      attr_accessor :meeting_key, :cancel_mail, :back_url,
        :start_feature, :app_handle, :location, :parameter, :url, :document_location,
        :attendee_name, :attendee_mail, :phone, :password, :registration_id,
        :meeting_name, :meeting_type, :list_flag, :meeting_password, :password_filter_feature,
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
        :lab_name, :number_of_computers, :invitation_email
    end
    # tracking_codes = [nil, nil, nil]

    def initialize(attributes = {})
      attributes.each { |k, v| send("#{k}=", v) }
      env_attributes! :back_url
      option_required! :back_url
    end

    def delete
      option_required! :meeting_key
      { params: generate_params(api_type: 'DM'),
        url: URI.join(CONFIGURATION.host_url + PATH_URL) }
    end

    def host
      option_required! :meeting_key
      { params: generate_params(api_type: 'HM'),
        url: URI.join(CONFIGURATION.host_url + PATH_URL) }
    end

    def join
      option_required! :meeting_key
      { params: generate_params(api_type: 'JM'),
        url: URI.join(CONFIGURATION.host_url + PATH_URL) }
    end

    def list_meetings
      { params: generate_params(api_type: 'LM'),
        url: URI.join(CONFIGURATION.host_url + PATH_URL) }
    end

    def list_open_meetings
      { params: generate_params(api_type: 'OM'),
        url: URI.join(CONFIGURATION.host_url + PATH_URL) }
    end

    def edit

    end

    def register

    end

    def schedule

    end

    def impromptu

    end

    private

    def cancel_mail?
      cancel_mail
    end

    def generate_params(overwrite_params = {})
      result = {}
      result[:AT] = overwrite_params[:api_type]
      result[:MK] = meeting_key
      result[:BU] = back_url
      # delete
      result[:SM] = cancel_mail?
      # host
      result[:AS] = start_feature
      result[:AH] = app_handle
      result[:AL] = location
      result[:AP] = parameter
      result[:DL] = document_location
      result[:WL] = url
      # join
      result[:AN] = attendee_name
      result[:AE] = attendee_mail
      result[:CO] = phone
      result[:PW] = password
      result[:RID] = registration_id
      # schedule
      result[:MN] = meeting_name
      result[:MT] = meeting_type
      result[:LF] = list_flag
      result[:PW] = meeting_password
      result[:PR] = password_filter_feature
      result[:AR] = require_attendee_registration
      result[:AQ] = automatically_accept_registration
      result[:AI] = attendee_information
      result[:RPW] = registration_password
      result[:NR] = maxinum_registrations_allowed
      result[:RCY] = registration_close_year
      result[:RCM] = registration_close_month
      result[:RMD] = registration_close_date
      result[:TC] = teleconference_configuration
      result[:IP] = internet_phone
      result[:TL] = tele_lines
      result[:TD] = other_teleconferencing_description
      result[:ExcludePW] = exclude_PW
      result[:RequestALogin] = request_login
      result[:TA] = tsp_account
      result[:APP] = if_auto_play_presentation
      result[:APPD] = document_location
      result[:AJ] = if_attendee_join_before_host
      result[:AJMI] = how_many_minutes_before_event_starts
      result[:NT] = if_note_taker
      result[:NTOP] = note_taker_option
      result[:TZ] = time_zone
      result[:DU] = duration
      result[:NA] = number_of_attendees
      result[:NP] = number_of_presenters
      # trachiing_codes
      result[:YE] = year
      result[:MO] = month
      result[:DA] = date
      result[:HO] = hour
      result[:MI] = minute
      result[:NS] = number_of_sessions
      result[:UntilYE] = until_year
      result[:UntilMO] = until_month
      result[:UntilDA] = until_day
      result[:TY] = recurrence_type # TC
      result[:RO] = recurrence_type # MC
      result[:Days] = repeat_days
      result[:Always] = always_repeat
      result[:Email] = reminder_email
      result[:ME] = meeting_email
      result[:BM] = if_send_reminder_email
      result[:ReminderTime] = time
      result[:MobileDN] = mobile_device_number
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
      result[:DS] = description
      result[:MD] = meeting_description
      result[:PM] = display_message
      result[:MG] = meeting_greeting
      result[:TA] = tsp_account # TC
      result[:QK] = if_request_attendee_to_check_rich_media_plays
      result[:CE] = if_send_a_confirmation_email_to_the_host
      result[:AutoDeleteAfterEnd] = auto_delete_after_after_end
      result[:CO] = callout_phone_number
      result[:HI] = host_web_ex_id
      result[:HL] = if_user_hands_on_lab
      result[:LN] = lab_name
      result[:NC] = number_of_computers
      result.delete_if { |k, v| v.nil? }
    end

    def attribute_length!(length, attribute)
      raise LengthError, %Q{option "#{attribute}" is too long.} if attribute.size > length
    end
  end
end
