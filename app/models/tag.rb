require 'data_mapper'
require 'dm-postgres-adapter'
require './app/models/tag.rb'


class Tag
  include DataMapper::Resource

  property :id,         Serial
  property :name,        String

  belongs_to :link, required: false
  has n, :links, through: Resource

end
