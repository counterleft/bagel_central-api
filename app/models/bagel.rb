class Bagel < ActiveRecord::Base
  belongs_to :owner, class_name: 'Player'
  belongs_to :teammate, class_name: 'Player'
  belongs_to :offensive_opponent, class_name: 'Player', foreign_key: 'opponent_1_id'
  belongs_to :defensive_opponent, class_name: 'Player', foreign_key: 'opponent_2_id'

  validates_datetime :baked_on, on: [:create, :update]

  def self.with_player_id(player_id)
    where('owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?',
          player_id,
          player_id,
          player_id,
          player_id)
  end

  validate :players_must_be_unique

  private

  def players_must_be_unique
    players = [owner_id, teammate_id, opponent_1_id, opponent_2_id].uniq
    possible_teams = players.combination(2)
    if possible_teams.size != 6
      errors.add(:base, 'A player cannot play multiple positions.')
    end
  end
end
