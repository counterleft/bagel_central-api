class Bagel < ActiveRecord::Base
  belongs_to :owner, class_name: "Player"
  belongs_to :teammate, class_name: "Player"
  belongs_to :opponent_1, class_name: "Player"
  belongs_to :opponent_2, class_name: "Player"

  validates_datetime :baked_on, on: [:create, :update]

  validate :players_must_be_unique

  private

  def players_must_be_unique
    players = [owner_id, teammate_id, opponent_1_id, opponent_2_id].uniq
    possible_teams = players.combination(2)
    if possible_teams.size != 6
      errors.add(:base, "A player cannot play multiple positions.")
    end
  end
end
