class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :replys, dependent: :destroy

  validates :answer, :presence => true

end
