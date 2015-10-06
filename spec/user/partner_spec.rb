require 'spec_helper'

describe Webex::User::Partner do
  before :each do
    ENV.stub(:[]).with("WEBEX_SITE_NAME").and_return("engsound")
    ENV.stub(:[]).with("WEBEX_WEBEX_ID").and_return("test1118")
    ENV.stub(:[]).with("WEBEX_PASSWORD").and_return("yeh1118")
    ENV.stub(:[]).with("WEBEX_BACK_TYPE").and_return("GoBack")
    ENV.stub(:[]).with("WEBEX_BACK_URL").and_return("localhost:3000")
  end

  context "login" do
    it '#api /p.php with custom set' do
      res = Webex::User::Partner.new(webex_id: "test1118", password: "yeh1118",back_type: 'GoBack', back_url: 'localhost:4567', email: "dyeh@sun-innovation.com").login
      expect(res['ST']).to eq 'SUCCESS'
    end

    it '#api /p.php with default set' do
      res = Webex::User::Partner.new.login
      expect(res['ST']).to eq 'SUCCESS'
    end
  end
end