class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable
  validates_presence_of :first_name, :last_name

  def name
    first_name + ' ' + last_name
  end
end
