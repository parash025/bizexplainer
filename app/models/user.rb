require 'digest/md5'

class User < ActiveRecord::Base
  has_secure_password

  has_many :projects
  has_many :messages

  before_validation :prep_email
  before_save :create_avatar_url

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def pending_projects
    self.projects.where(project_status: 'Pending')
  end

  def processing_projects
    self.projects.where(project_status: 'Processing')
  end

  def completed_projects
    self.projects.where(project_status: 'Complete')
  end



  private

  def prep_email
    self.email = self.email.strip.downcase if self.email
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravata.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end
end

