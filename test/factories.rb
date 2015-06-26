FactoryGirl.define do
  factory :player do
    name "Name"
    surname "Surname"
    active true
    plus_minus 0

    factory :duplicate_player do
      id 7777
      name "Duplicate"
      initialize_with { Player.where(id: id).first_or_create }
    end

    factory :alice do
      id 1
      name "Alice"
      initialize_with { Player.where(id: id).first_or_create }
    end

    factory :sally do
      id 2
      name "Sally"
      initialize_with { Player.where(id: id).first_or_create }
    end

    factory :jill do
      id 3
      name "Jill"
      initialize_with { Player.where(id: id).first_or_create }
    end

    factory :jane do
      id 4
      name "Jane"
      initialize_with { Player.where(id: id).first_or_create }
    end
  end

  factory :bagel do
    baked_on DateTime.now
    association :owner, factory: :alice
    association :teammate, factory: :sally
    association :opponent_1, factory: :jill
    association :opponent_2, factory: :jane
  end
end
