require 'spec_helper'

describe Webex::Configuration do
  context "with all environment variables present" do
    before :each do
      ENV.stub(:[]).with("WEBEX_SITE_NAME").and_return("engsound")
      ENV.stub(:[]).with("WEBEX_WEBEX_ID").and_return("test1118")
      ENV.stub(:[]).with("WEBEX_PASSWORD").and_return("yeh1118")
      ENV.stub(:[]).with("WEBEX_SITE_ID").and_return("358562")
      ENV.stub(:[]).with("WEBEX_PARTNER_ID").and_return("123ab")
    end

    it { Webex::Configuration.site_name.should == "engsound" }
    it { Webex::Configuration.webex_id.should == "test1118" }
    it { Webex::Configuration.password.should == "yeh1118" }
    it { Webex::Configuration.site_id.should == "358562" }
    it { Webex::Configuration.partner_id.should == "123ab" }
    it { Webex::Configuration.host_url.should == "https://engsound.webex.com/engsound" }
  end
end
