module Webex
  # Generic WebexError exception class.
  class WebexError < StandardError; end

  class ConfigurationError < WebexError; end
  class BackTypeError < ConfigurationError; end

  class MissingOption < WebexError; end
  class PartnerError < WebexError; end

  class RegistrationError < WebexError; end
  class LengthError < RegistrationError; end
end
