# encoding: UTF-8
$: << File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
require 'sinatra'
require 'webex'

get '/' do
  @partner = Webex::User::Partner.new({ webex_id: 'test', password: 'yeh',back_type: 'GoBack', back_url: 'localhost:4567', email: 'bird1204@gmail.com' }).login
  # @partner = Webex::User::Partner.new(webex_id: "test1118", password: "yeh1118", back_type: 'GoBack', back_url: 'localhost:4567', email: 'fewhi.cewf@fiof.com')
  # @url =  URI.join(Webex::Configuration.host_url + @partner.path)
  erb :'user/partner/login'
end

get '/logout' do
  @partner = Webex::User::Partner.new({ webex_id: 'test', password: 'yeh',back_type: 'GoBack', back_url: 'localhost:4567', email: 'bird1204@gmail.com' }).logout
  erb :'user/partner/logout'
end

get '/sign_up' do
  @partner = Webex::User::Registration.new({ webex_id: 'bird1204', password: 'yeh1118', email: 'bird1204@gmail.com', partner_id: 'test1118', first_name: 'first', last_name: 'last', back_url: 'localhost:4567' }).sign_up
  erb :'user/registration/sign_up'
end

get '/edit' do
  @partner = Webex::User::Registration.new({ webex_id: 'test', password: 'yeh1118', email: 'bird1204@gmail.com', partner_id: 'test12312', first_name: 'first', last_name: 'last' }).edit
  erb :'user/registration/edit'
end

post  '/' do
  erb :back_page
end
