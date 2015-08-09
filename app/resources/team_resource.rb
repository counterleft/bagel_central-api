class TeamResource < JSONAPI::Resource
  attributes :offense_given_name, :defense_given_name

  has_one :offense, class_name: 'Player'
  has_one :defense, class_name: 'Player'
end
