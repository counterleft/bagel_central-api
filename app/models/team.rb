class Team
  attr_reader :offense, :defense

  def initialize(offense, defense)
    @offense = offense
    @defense = defense
  end

  def offense_given_name
    offense.given_name
  end

  def defense_given_name
    defense.given_name
  end

  def eql?(obj)
    offense == obj.offense && defense == obj.defense
  end
end
