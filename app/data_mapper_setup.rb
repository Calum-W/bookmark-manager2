require 'dm-migrations'
require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'models/user'

require_relative 'models/tag'
require_relative 'models/link'

# DataMapper::Logger.new($stdout, :debug)

p ENV['RACK_ENV']

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
