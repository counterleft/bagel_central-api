class Player < ActiveRecord::Base
  validates :name, presence: true

  has_many :bagels

  alias_attribute :given_name, :name
  alias_attribute 'given_name=', 'name='

  def eql?(obj)
    id == obj.id
  end
end
