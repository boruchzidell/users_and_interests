#! /usr/bin/env ruby

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  @users_interests = YAML.load_file('./interests.yml')
  @user_list = @users_interests.keys
end

helpers do
  def count_interests
    @users_interests.map {|_,v| v[:interests] }.flatten.count
  end

  def count_users
    @user_list.count
  end

end

get "/" do
  redirect "/directory"
end

get "/directory" do
  erb :directory
end

get "/:name" do
  @name = params[:name]
  user_info = @users_interests[@name.to_sym]
  
  @email = user_info[:email]

  @interests = user_info[:interests].join(', ')

  @other_users = @user_list.reject { |user| user == @name.to_sym}
  erb :user
end
