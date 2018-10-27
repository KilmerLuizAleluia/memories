class Memory < ApplicationRecord
  belongs_to :user

  def formatted_date
    self.date.strftime('%B %d, %Y at %I:%M %p')
  end
end
