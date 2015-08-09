require 'set'

class TeamService
  def self.find_teams_for(player_id)
    new.find_teams_for(player_id)
  end

  def find_teams_for(player_id)
    player_id = player_id.to_i
    fail ArgumentError if player_id < 1

    bagels = Bagel.with_player_id(player_id)
      .includes(:owner, :teammate, :offensive_opponent, :defensive_opponent)

    teams = form_teams(player_id, bagels)

    teams.to_a
  end

  private

  def form_teams(player_id, bagels)
    teams = Set.new

    bagels.each do |bagel|
      if losing_team?(player_id, bagel)
        teams << Team.new(defense: bagel.owner, offense: bagel.teammate)
      elsif winning_team?(player_id, bagel)
        teams << Team.new(offense: bagel.offensive_opponent, defense: bagel.defensive_opponent)
      end
    end

    teams
  end

  def losing_team?(player_id, bagel)
    player_id == bagel.owner.id || player_id == bagel.teammate.id
  end

  def winning_team?(player_id, bagel)
    player_id == bagel.offensive_opponent.id ||
      player_id == bagel.defensive_opponent.id
  end
end
