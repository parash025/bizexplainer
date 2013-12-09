class AddAttachmentDocumentToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :attachments, :document
  end
end
