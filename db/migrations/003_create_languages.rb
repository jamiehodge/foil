Sequel.migration do
  change do
    create_table :languages do
      primary_key :id

      text :code, null: false, unique: true
      text :name, null: false

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :name
    end

    create_trigger :languages, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update
  end
end