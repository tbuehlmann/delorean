class Issue < ActiveRecord::Base
  enum status: [:open, :closed]
  belongs_to :project, touch: true, counter_cache: true

  scope :ordered, -> { order(status: :asc, updated_at: :desc) }

  validates :title, presence: true, uniqueness: {scope: :project_id}, length: {maximum: 128}
  validates :description, length: {maximum: 512}
  validates :project, :status, presence: true
end
