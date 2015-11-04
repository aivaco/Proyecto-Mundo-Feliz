class AddAttachmentFotoToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :users, :foto
  end
end
