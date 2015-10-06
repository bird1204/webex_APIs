module Webex
  # Generic Allpay exception class.
  class WebexError < StandardError; end
  class MissingOption < WebexError; end
  class InvalidMode < WebexError; end
end