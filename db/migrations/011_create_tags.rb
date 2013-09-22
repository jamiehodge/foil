Sequel.migration do
  change do
    create_table :tags do
      primary_key :id

      text :name, null: false, unique: true

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :name
    end

    create_trigger :tags, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update

    create_join_table file_id: :files, tag_id: :tags
    create_join_table tag_id:  :tags, utterance_id: :utterances
  end
end