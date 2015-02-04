class Issue < ActiveRecord::Base
  enum status: [:open, :closed]

  belongs_to :project, touch: true, counter_cache: true
  has_many :records, dependent: :delete_all

  scope :ordered, -> { order(status: :asc, updated_at: :desc) }
  scope :with_worked, -> { joins(:records).select('issues.*', 'SUM(records.worked) AS worked').group('issues.id') }

  validates :title, presence: true, uniqueness: {scope: :project_id}, length: {maximum: 128}
  validates :description, length: {maximum: 512}
  validates :project, :status, presence: true
end
