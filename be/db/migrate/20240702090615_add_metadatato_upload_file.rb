class AddMetadatatoUploadFile < ActiveRecord::Migration[7.1]
  def change
    add_column :upload_files, :metadata, :json
  end
end
