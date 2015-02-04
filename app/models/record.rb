class Record < ActiveRecord::Base
  belongs_to :issue

  scope :ordered, -> { order(updated_at: :desc) }

  validates :issue, :worked_at, presence: true
  validates :worked, numericality: {only_integer: true, greater_than: 0}
end
