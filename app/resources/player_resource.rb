class PlayerResource < JSONAPI::Resource
  attributes :name, :surname, :created_at, :updated_at, :active, :plus_minus
  attribute :full_name

  has_many :bagels

  def full_name
    "#{model.name} #{model.surname}".rstrip!
  end

  def records_for_bagels(options = {})
    Bagel.where("owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
                id,
                id,
                id,
                id)
  end

  def self.updatable_fields(context)
    super - [:full_name, :created_at, :updated_at, :plus_minus]
  end

  def self.creatable_fields(context)
    super - [:full_name, :created_at, :updated_at, :plus_minus, :active]
  end
end
