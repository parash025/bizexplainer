class Deliverable < ActiveRecord::Base
  belongs_to :project

  has_attached_file :document, url: "/final_documents/:filename", path: ":rails_root/public/final_documents/:filename"
end
