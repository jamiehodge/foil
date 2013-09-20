Sequel.migration do
  change do
    create_table :links do
      primary_key :id

      text :url, null: false, unique: true

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :url
    end

    create_trigger :links, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update

    create_join_table file_id: :files, link_id: :links
  end
end