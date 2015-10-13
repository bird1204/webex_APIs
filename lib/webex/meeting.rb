require 'webex/meeting/presenter'
require 'webex/meeting/attendee'
require 'webex/meeting/action'
module Webex
  # comment
  module Meeting
    PATH_URL = 'm.php'.freeze
    def env_attributes!(*env_variables)
      env_variables.each do |attribute|
        if %w( site_name webex_id password back_type back_url).include?(attribute.to_s)
          send("#{attribute}=", CONFIGURATION.send(attribute)) unless send(attribute)
        end
      end
    end

    def option_required!(*option_names)
      option_names.each do |option_name|
        raise MissingOption, %Q{option "#{option_name}" is required.} unless send(option_name)
      end
    end
  end
end
