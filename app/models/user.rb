class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  def name
    self.first_name + ' ' + self.last_name
  end
end
