class AddAttachmentDocumentToDeliverables < ActiveRecord::Migration
  def self.up
    change_table :deliverables do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :deliverables, :document
  end
end
