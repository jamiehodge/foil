Sequel.migration do
  change do
    extension :pg_range

    create_table :issues do
      primary_key :id

      foreign_key :file_id, :files, index: true, null: false, on_delete: :cascade

      text :person_id, null: false
      text :note, null: false

      numrange :range, default: (0..0), null: false

      boolean :open, default: true

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :note
    end
  end
end