class OriginalSchema < ActiveRecord::Migration
  def self.up
    create_table "bagels", id: false, force: true do |t|
      t.integer  "id", null: false
      t.integer  "owner_id"
      t.integer  "teammate_id"
      t.integer  "opponent_1_id"
      t.integer  "opponent_2_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "baked_on"
    end

    create_table "players", id: false, force: true do |t|
      t.integer  "id", null: false
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "plus_minus", default: 0, null: false
      t.boolean  "active", default: true
      t.string   "surname"
    end
  end

  def self.down
    drop_table "bagels"
    drop_table "players"
  end
end
