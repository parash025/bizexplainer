class Project < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :deliverables, dependent: :destroy

  accepts_nested_attributes_for :assets
  accepts_nested_attributes_for :deliverables


  def self.get_all_projects(order = :desc)
      Project.all.order(created_at: order)
  end

end
