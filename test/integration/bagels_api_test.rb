require "test_helper"

class BagelsApiTest < ActionDispatch::IntegrationTest
  def test_get_bagel_by_id
    get "/bagels/1"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('1', actual['data']['id'])
    assert_equal('bagels', actual['data']['type'])
    assert_not_nil(actual['data']['attributes']['baked-on'])
    assert_equal('http://www.example.com/bagels/1/owner', actual['data']['relationships']['owner']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/teammate', actual['data']['relationships']['teammate']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/offensive-opponent', actual['data']['relationships']['offensive-opponent']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/defensive-opponent', actual['data']['relationships']['defensive-opponent']['links']['related'])
  end

  def test_get_bagel_and_include_players
    get "/bagels/1?include=owner,teammate,offensive-opponent,defensive-opponent"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('1', actual['data']['id'])
    assert_equal('bagels', actual['data']['type'])
    assert_not_nil(actual['data']['attributes']['baked-on'])
    assert_equal('players', actual['data']['relationships']['owner']['data']['type'])
    assert_equal('players', actual['data']['relationships']['teammate']['data']['type'])
    assert_equal('players', actual['data']['relationships']['offensive-opponent']['data']['type'])
    assert_equal('players', actual['data']['relationships']['defensive-opponent']['data']['type'])
    assert_equal('1', actual['data']['relationships']['owner']['data']['id'])
    assert_equal('2', actual['data']['relationships']['teammate']['data']['id'])
    assert_equal('3', actual['data']['relationships']['offensive-opponent']['data']['id'])
    assert_equal('4', actual['data']['relationships']['defensive-opponent']['data']['id'])
    assert_equal('http://www.example.com/bagels/1/owner', actual['data']['relationships']['owner']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/teammate', actual['data']['relationships']['teammate']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/offensive-opponent', actual['data']['relationships']['offensive-opponent']['links']['related'])
    assert_equal('http://www.example.com/bagels/1/defensive-opponent', actual['data']['relationships']['defensive-opponent']['links']['related'])
  end

  def test_get_owner_related_to_bagel
    get "/bagels/1/owner"

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

  def test_get_teammate_related_to_bagel
    get "/bagels/1/teammate"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('2', actual['data']['id'])
    assert_equal('players', actual['data']['type'])
    assert_equal('Sally', actual['data']['attributes']['given-name'])
    assert_equal('Surname', actual['data']['attributes']['surname'])
    assert_not_nil(actual['data']['attributes']['created-at'])
    assert_not_nil(actual['data']['attributes']['updated-at'])
    assert_equal(true, actual['data']['attributes']['active'])
    assert_equal(0, actual['data']['attributes']['plus-minus'])
    assert_equal('Sally Surname', actual['data']['attributes']['full-name'])
    assert_equal('http://www.example.com/players/2/bagels', actual['data']['relationships']['bagels']['links']['related'])
  end

  def test_get_offensive_opponent_related_to_bagel
    get "/bagels/1/offensive-opponent"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('3', actual['data']['id'])
    assert_equal('players', actual['data']['type'])
    assert_equal('Jill', actual['data']['attributes']['given-name'])
    assert_equal('Surname', actual['data']['attributes']['surname'])
    assert_not_nil(actual['data']['attributes']['created-at'])
    assert_not_nil(actual['data']['attributes']['updated-at'])
    assert_equal(true, actual['data']['attributes']['active'])
    assert_equal(0, actual['data']['attributes']['plus-minus'])
    assert_equal('Jill Surname', actual['data']['attributes']['full-name'])
    assert_equal('http://www.example.com/players/3/bagels', actual['data']['relationships']['bagels']['links']['related'])
  end

  def test_get_defensive_opponent_related_to_bagel
    get "/bagels/1/defensive-opponent"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal('4', actual['data']['id'])
    assert_equal('players', actual['data']['type'])
    assert_equal('Jane', actual['data']['attributes']['given-name'])
    assert_equal('Surname', actual['data']['attributes']['surname'])
    assert_not_nil(actual['data']['attributes']['created-at'])
    assert_not_nil(actual['data']['attributes']['updated-at'])
    assert_equal(true, actual['data']['attributes']['active'])
    assert_equal(0, actual['data']['attributes']['plus-minus'])
    assert_equal('Jane Surname', actual['data']['attributes']['full-name'])
    assert_equal('http://www.example.com/players/4/bagels', actual['data']['relationships']['bagels']['links']['related'])
  end

  def test_get_bagels
    get "/bagels"

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_not_empty(actual['data'])
    actual['data'].each do |data|
      assert_equal("bagels", data['type'])
    end
  end

  def test_bagels_page_size_defaults
    (1..25).each { create(:bagel) }

    get "/bagels"
    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_equal(20, actual['data'].size)

    get "/bagels?page[size]=100"
    assert_response 200

    get "/bagels?page[size]=999"
    assert_response 400
  end
end
