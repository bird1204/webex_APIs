require 'webex/user/partner'
require 'webex/user/registration'
require 'webex/user/activation'
require 'webex/user/file'
require 'webex/user/report'
module Webex
  # comment
  module User
    PATH_URL = 'p.php'.freeze
    CONFIGURATION = Webex::Configuration

    def env_attributes!(*env_variables)
      env_variables.each do |attribute|
        send("#{attribute}=", CONFIGURATION.send(attribute)) unless send(attribute)
      end
    end

    def option_required!(*option_names)
      option_names.each do |option_name|
        raise MissingOption, %Q{option "#{option_name}" is required.} unless send(option_name)
      end
    end
  end
end
