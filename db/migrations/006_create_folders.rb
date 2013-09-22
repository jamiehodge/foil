Sequel.migration do
  change do
    create_table :folders do
      primary_key :id
      foreign_key :parent_id, :folders, on_delete: :cascade, index: true

      text :name,        null: false
      text :description, null: false

      boolean :public, null: false, default: false

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :name
    end

    create_trigger :folders, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update

    create_join_table file_id: :files, folder_id: :folders
  end
end