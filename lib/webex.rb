require 'core_ext/string'
require 'webex/error/errors'
require 'webex/version'
require 'webex/configuration'
require 'webex/user'
require 'webex/meeting'
# comment
module Webex
  def env_attributes!
    %w( site_name webex_id password back_type back_url).each do |attribute|
      begin
        send("#{attribute}=", CONFIGURATION.send(attribute)) unless send(attribute)
      rescue NoMethodError
        next
      end
    end
  end

  def option_required!(*option_names)
    option_names.each do |option_name|
      raise MissingOption, %Q{option "#{option_name}" is required.} unless send(option_name)
    end
  end
end
