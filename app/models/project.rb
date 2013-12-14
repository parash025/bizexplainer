class Project < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :assets, dependent: :destroy

  accepts_nested_attributes_for :assets

end
