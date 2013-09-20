require 'logger'
require 'sequel'

Sequel.extension :blank, :pg_array_ops
Sequel::Database.extension :pagination

module Foil
  DB ||= Sequel.connect(ENV['DATABASE_URL']).tap do |db|
    db.extension :pg_array, :pg_range
    db.loggers << Logger.new(STDOUT) if ENV['DEBUG']
  end
end

