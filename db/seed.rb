require_relative '../lib/foil/db'

Foil::DB.transaction do

  Foil::DB.copy_into :categories, \
    columns: [:code, :parent_id, :name], \
    format: :csv,
    data: File.read(File.expand_path('csv/categories.csv', __dir__))

  Foil::DB.copy_into :languages, \
    columns: [:code, :name], \
    format: :csv,
    data: File.read(File.expand_path('csv/languages.csv', __dir__))

  Foil::DB.copy_into :licenses, \
    columns: [:code, :name], \
    format: :csv,
    data: File.read(File.expand_path('csv/licenses.csv', __dir__))
end