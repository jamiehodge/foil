Sequel.migration do
  change do
    create_table :categories do
      primary_key :id

      foreign_key :parent_id, :categories, on_delete: :cascade, index: true

      text :code, null: false
      text :name, null: false

      unique [:code, :parent_id]

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index :name
    end

    create_trigger :categories, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update
  end
end