require "test_helper"

class PlayersApiTest < ActionDispatch::IntegrationTest
  def test_get_player_by_id
    get "/players/1"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('1', actual['data']['id'])
    assert_equal('players', actual['data']['type'])
    assert_equal('Alice', actual['data']['attributes']['given-name'])
    assert_equal('Surname', actual['data']['attributes']['surname'])
    assert_not_nil(actual['data']['attributes']['created-at'])
    assert_not_nil(actual['data']['attributes']['updated-at'])
    assert_equal(true, actual['data']['attributes']['active'])
    assert_equal(0, actual['data']['attributes']['plus-minus'])
    assert_equal('Alice Surname', actual['data']['attributes']['full-name'])
    assert_equal('http://www.example.com/players/1/bagels', actual['data']['relationships']['bagels']['links']['related'])
  end

  def test_get_bagels_related_to_player
    get "/players/1/bagels"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('1', actual['data'][0]['id'])
    assert_equal('bagels', actual['data'][0]['type'])
    assert_not_nil(actual['data'][0]['attributes']['baked-on'])
    assert_equal('http://www.example.com/bagels/1/owner', actual['data'][0]['relationships']['owner']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/teammate', actual['data'][0]['relationships']['teammate']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/offensive-opponent', actual['data'][0]['relationships']['offensive-opponent']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/defensive-opponent', actual['data'][0]['relationships']['defensive-opponent']['links']['related'])
  end

  def test_get_bagels_related_to_player_and_include_players
    get "/players/1/bagels?include=owner,teammate,offensive-opponent,defensive-opponent"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('1', actual['data'][0]['id'])
    assert_equal('bagels', actual['data'][0]['type'])
    assert_not_nil(actual['data'][0]['attributes']['baked-on'])
    assert_equal('players', actual['data'][0]['relationships']['owner']['data']['type'])
    assert_equal('players', actual['data'][0]['relationships']['teammate']['data']['type'])
    assert_equal('players', actual['data'][0]['relationships']['offensive-opponent']['data']['type'])
    assert_equal('players', actual['data'][0]['relationships']['defensive-opponent']['data']['type'])
    assert_equal('1', actual['data'][0]['relationships']['owner']['data']['id'])
    assert_equal('2', actual['data'][0]['relationships']['teammate']['data']['id'])
    assert_equal('3', actual['data'][0]['relationships']['offensive-opponent']['data']['id'])
    assert_equal('4', actual['data'][0]['relationships']['defensive-opponent']['data']['id'])
    assert_equal('http://www.example.com/bagels/1/owner', actual['data'][0]['relationships']['owner']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/teammate', actual['data'][0]['relationships']['teammate']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/offensive-opponent', actual['data'][0]['relationships']['offensive-opponent']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/defensive-opponent', actual['data'][0]['relationships']['defensive-opponent']['links']['related'])
  end

  def test_get_players
    get "/players"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_not_empty(actual['data'])
    actual['data'].each do |data|
      assert_equal("players", data['type'])
    end
  end

  def test_players_page_size_defaults
    (1..25).each { create(:player) }

    get "/players"
    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal(20, actual['data'].size)

    get "/players?page[size]=100"
    assert_response 200

    get "/players?page[size]=999"
    assert_response 400
  end
end
