module Webex
  class Configuration
    %w( site_name webex_id password back_type back_url).each do |name|
      define_singleton_method(name) { ENV["WEBEX_#{name.upcase}"] }
    end

    def self.host_url
    	if site_name
      	"https://#{site_name}.webex.com/#{site_name}/"
      else
      	"https://engsound.webex.com/engsound/"
      end
    end
  end
end
