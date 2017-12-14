require 'data_mapper'
require 'dm-postgres-adapter'


class Tag
  include DataMapper::Resource

  property :id,         Serial
  property :name,        String

  belongs_to :link, required: false
  has n, :links, through: Resource

end
