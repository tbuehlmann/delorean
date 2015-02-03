class Project < ActiveRecord::Base
  has_many :issues, -> { ordered }, dependent: :destroy
  scope :ordered, -> { order(updated_at: :desc) }
  validates :name, presence: true, uniqueness: true, length: {maximum: 128}
end
