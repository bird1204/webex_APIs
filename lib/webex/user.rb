require 'webex/user/partner'
require 'webex/user/registration'
require 'webex/user/activation'
require 'webex/user/file'
require 'webex/user/report'

module Webex
  # comment
  module User
    PATH_URL = 'p.php'.freeze
    def post_url
      URI.join(CONFIGURATION.host_url + PATH_URL)
    end
  end
end
