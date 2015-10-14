module Webex
  # comment
  class Configuration
    %w( site_name webex_id password back_type back_url).each do |name|
      define_singleton_method(name) { ENV["WEBEX_#{name.upcase}"] }
    end

    def self.host_url
      "https://#{site_name}.webex.com/#{site_name}/"
      # "https://engsound.webex.com/engsound/"
    end
  end
  CONFIGURATION = Webex::Configuration
end
