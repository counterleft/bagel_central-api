require "set"

class TeamService
  def self.find_teams_for(player_id)
    player_id = player_id.to_i
    raise ArgumentError if player_id < 1

    bagels = Bagel.where("owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
                player_id,
                player_id,
                player_id,
                player_id)
      .includes(:owner, :teammate, :offensive_opponent, :defensive_opponent)

    teams = Set.new

    bagels.each do |bagel|
      if player_id == bagel.owner.id || player_id == bagel.teammate.id
        teams << Team.new(bagel.owner, bagel.teammate)
      elsif player_id == bagel.offensive_opponent.id || player_id == bagel.defensive_opponent.id
        teams << Team.new(bagel.offensive_opponent, bagel.defensive_opponent)
      end
    end

    teams.to_a
  end
end
