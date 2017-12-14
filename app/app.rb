require 'sinatra'
require 'sinatra/base'
require './app/models/link'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base

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
    tag = Tag.first_or_create(name: params[:tag])
    link.tags << tag
    link.save
    redirect to('/links')
  end

  get 'tags/:tag_name' do
    @links = Link.all
    @tag_name = params[:tag_name]
    @tagged_links = @links.tags.select { |tag| tag.name = @tag_name }
    erb :'tags'
  end
end
