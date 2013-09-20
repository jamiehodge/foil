Sequel.migration do
  up do
    run 'CREATE EXTENSION moddatetime'
    run 'CREATE EXTENSION "uuid-ossp"'
  end
  down do
    run 'DROP EXTENSION moddatetime'
    run 'DROP EXTENSION "uuid-ossp"'
  end
end