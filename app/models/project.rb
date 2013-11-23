class Project < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  after_initialize :init

  has_attached_file :document, url: "/documents/:filename", path: ":rails_root/public/documents/:filename"


  def init
    self.payment_status = 'Pending'
    self.project_status = 'Pending'
  end

end
