ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'sinatra/base'
require './app/models/link'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/links' do
    @links = Link.all
    @tags = Tag.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/add_link'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                    title: params[:title])
    params[:tag].split.each do |t|
      tag = Tag.first_or_create(name: t)
      link.tags << tag
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:tag_name' do
    tag = Tag.first(name: params[:tag_name])
    @links = tag ? tag.links : []
    @tags = Tag.all
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end


  post '/users' do
    user = User.create(email: params[:email],
                       password: params[:password])
    session[:user_id] = user.id
    redirect to('/links')
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end
end
