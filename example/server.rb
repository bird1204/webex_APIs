# encoding: UTF-8
$: << File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'sinatra'
require 'webex'

get '/' do
  @partner = Webex::User::Partner.new(webex_id: "test1118", password: "yeh1118", back_type: 'GoBack', back_url: 'localhost:4567')
  # @partner = Webex::User::Partner.new(webex_id: "test1118", password: "yeh1118", back_type: 'GoBack', back_url: 'localhost:4567', email: 'fewhi.cewf@fiof.com')
  # @url =  URI.join(Webex::Configuration.host_url + @partner.path)
  erb :'user/partner/login'
end

get '/logout' do
  @partner = Webex::User::Partner.new(webex_id: "test111", password: "yeh1118", back_type: 'GoBack', back_url: 'localhost:4567')
  erb :'user/partner/logout'
end

post  '/' do
  erb :back_page
end
