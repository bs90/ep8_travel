class CreateUploadFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :upload_files do |t|
      t.string :key
      t.string :file_name
      t.string :content_type
      t.references :resource, polymorphic: true, null: false
      t.integer :field_type

      t.timestamps
    end
  end
end
