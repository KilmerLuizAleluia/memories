class Memory < ApplicationRecord
  belongs_to :user
  validates_presence_of :description
  scope :ordered_by_attributes, -> { order('date DESC, weather, local') }

  def formatted_date
    date.strftime('%B %d, %Y')
  end
end
