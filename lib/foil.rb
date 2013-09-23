require_relative 'foil/db'
require_relative 'foil/directory'
require_relative 'foil/model'
require_relative 'foil/storage'

Foil::Model::Group.directory  = Foil::Directory::LDAP::Group
Foil::Model::Person.directory = Foil::Directory::LDAP::Person
Foil::Model::File.storage = Foil::Storage::Local.new(ENV['STORAGE_PATH'])

