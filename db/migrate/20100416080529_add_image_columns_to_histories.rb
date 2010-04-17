class AddImageColumnsToHistories < ActiveRecord::Migration
  def self.up
    add_column :histories, :image_file_name,    :string
    add_column :histories, :image_content_type, :string
    add_column :histories, :image_file_size,    :integer
    add_column :histories, :image_updated_at,   :datetime
  end

  def self.down
    remove_column :histories, :image_file_name
    remove_column :histories, :image_content_type
    remove_column :histories, :image_file_size
    remove_column :histories, :image_updated_at
  end
end
