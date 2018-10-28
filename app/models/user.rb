class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  def name
    first_name + ' ' + last_name
  end
end
