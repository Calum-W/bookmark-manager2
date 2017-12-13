require 'data_mapper'
require 'dm-postgres-adapter'


DataMapper::Logger.new($stdout, :debug)


class Tag
  include DataMapper::Resource

  property :id,         Serial
  property :name,        String

  belongs_to :link, required: false
  
end
