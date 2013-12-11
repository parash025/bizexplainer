class Project < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :assets, dependent: :destroy

  accepts_nested_attributes_for :assets


  after_initialize :init


  def init
    self.payment_status = 'Pending'
    self.project_status = 'Pending'
  end

end
