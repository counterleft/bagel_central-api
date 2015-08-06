class Team
  attr_reader :offense, :defense
  delegate :given_name, to: :offense, prefix: 'offense'
  delegate :given_name, to: :defense, prefix: 'defense'

  def initialize(offense, defense)
    @offense = offense
    @defense = defense
  end

  def ==(other)
    offense == other.offense && defense == other.defense
  end

  alias eql? ==
end
