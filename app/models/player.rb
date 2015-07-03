class Player < ActiveRecord::Base
  validates :name, presence: true

  has_many :bagels
end
