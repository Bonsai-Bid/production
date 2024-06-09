class Inquiry < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  belongs_to :auction

  has_many :replies, as: :respondable, dependent: :destroy
  belongs_to :parent, class_name: 'Inquiry', optional: true

  validates :comment, presence: true

end
