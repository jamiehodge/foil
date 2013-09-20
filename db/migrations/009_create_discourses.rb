Sequel.migration do
  change do
    create_table :discourses do
      primary_key :id

      text :name, null: false
      text :description, null: false

      boolean :public, null: false, default: false

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index [:name, :description]
    end

    create_join_table discourse_id: :discourses, folder_id: :folders
  end
end