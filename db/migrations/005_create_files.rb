Sequel.migration do
  change do
    create_table :files do
      primary_key :id

      foreign_key :category_id,   :categories,   index: true, null: false
      foreign_key :language_id,   :languages,    index: true, null: false
      foreign_key :license_id,    :licenses,     index: true, null: false

      text   :name,        null: false
      text   :description, null: false

      column :person_ids,  'text[]', null: false

      boolean :public, null: false, default: false

      timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP, null: false
      timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP, null: false

      integer :lock_version, default: 0, null: false

      full_text_index [:name, :description]
    end

    create_trigger :files, :timestamp, :moddatetime,
      args: :updated_at, each_row: true, events: :update
  end
end