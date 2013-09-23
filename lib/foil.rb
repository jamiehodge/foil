require_relative 'foil/db'
require_relative 'foil/directory'
require_relative 'foil/model'

Foil::Model::Group.directory  = Foil::Directory::LDAP::Group
Foil::Model::Person.directory = Foil::Directory::LDAP::Person
