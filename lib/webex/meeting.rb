require 'webex/meeting/presenter'
require 'webex/meeting/attendee'
require 'webex/meeting/action'
require 'webex/meeting/schedule'
require 'webex/meeting/registration'
require 'webex/meeting/report'

module Webex
  # comment
  module Meeting
    PATH_URL = 'm.php'.freeze
    def post_url
      URI.join(CONFIGURATION.host_url + PATH_URL)
    end
  end
end
