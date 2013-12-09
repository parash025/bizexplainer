class Asset < ActiveRecord::Base
  belongs_to :project

  has_attached_file :document, url: "/documents/:filename", path: ":rails_root/public/documents/:filename"

end
