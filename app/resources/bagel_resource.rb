class BagelResource < JSONAPI::Resource
  attributes :baked_on, :created_at, :updated_at

  has_one :owner, class_name: "Player"
  has_one :teammate, class_name: "Player"
  has_one :offensive_opponent, class_name: "Player", foreign_key: "opponent_1_id"
  has_one :defensive_opponent, class_name: "Player", foreign_key: "opponent_2_id"

  def self.updatable_fields(context)
    super + [:offensive_opponent, :defensive_opponent] - [:created_at, :updated_at]
  end

  def self.creatable_fields(context)
    super + [:offensive_opponent, :defensive_opponent] - [:created_at, :updated_at]
  end
end
