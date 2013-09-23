Sequel.migration do
  change do
    create_table :permissions do
      primary_key :id

      boolean :write,  default: false
      boolean :delete, default: false

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false
    end

    create_trigger :permissions, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update

    create_table :discourse_permissions, inherits: :permissions do
      foreign_key :discourse_id, :discourses, index: true, null: false, on_delete: :cascade
    end

    create_table :file_permissions, inherits: :permissions do
      foreign_key :file_id, :files, index: true, null: false, on_delete: :cascade
    end

    create_table :folder_permissions, inherits: :permissions do
      foreign_key :folder_id, :folders, index: true, null: false, on_delete: :cascade
    end

    create_table :group_discourse_permissions, inherits: :discourse_permissions do
      integer :group_id, null: false
    end

    create_table :person_discourse_permissions, inherits: :discourse_permissions do
      integer :person_id, null: false
    end

    create_table :group_file_permissions, inherits: :file_permissions do
      integer :group_id, null: false
    end

    create_table :person_file_permissions, inherits: :file_permissions do
      integer :person_id, null: false
    end

    create_table :group_folder_permissions, inherits: :folder_permissions do
      integer :group_id, null: false
    end

    create_table :person_folder_permissions, inherits: :folder_permissions do
      integer :person_id, null: false
    end
  end
end