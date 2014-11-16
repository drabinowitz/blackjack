assert = chai.assert
spy = sinon.spy

describe 'Game event handler', ->
  game = null
  spygame = null
  spygame2 = null
  spygame3 = null

  beforeEach ->
    game = new Game()
    spygame = spy game, 'handleHand'
    spygame2 = spy game, 'handleStand'
    spygame3 = spy game, 'trigger'

  it "should listen to player or dealer going over 21", ->
    game.get('playerHand').trigger 'over21', game.get 'playerHand'
    assert.isTrue spygame.calledWith game.get 'playerHand'

  it "should declare player or dealer is the winner", ->
    assert.strictEqual game.handleHand(game.get('playerHand')), game.get('dealerHand')
    assert.strictEqual game.handleHand(game.get('dealerHand')), game.get('playerHand')

  it "should listen to player or dealer stand", ->
    game.get('playerHand').trigger 'stand', game.get 'playerHand'
    assert.isTrue spygame2.calledWith game.get 'playerHand'

  describe 'handle stand', ->
    it "should determine a winner if the dealer stand", ->
      callback = (value) ->
        if value <= 21
          return value
        else
          return 0

      greatestScore = if _.max(game.get('playerHand').scores(), callback) > _.max(game.get('dealerHand').scores(), callback) then game.get('playerHand') else game.get('dealerHand')
      assert.strictEqual game.handleStand(game.get('dealerHand')), greatestScore

    describe "dealer play", ->
      it "keeps hitting until their score greater than player or over 21", ->
        do game.dealerPlay
        assert.isTrue _.max(game.get('playerHand').scores()) <= _.max(game.get('dealerHand').scores())

  describe "winning event", ->
    it "should trigger a winner event", ->
      game.handleStand(game.get('dealerHand'))
      callback = (value) ->
        if value <= 21
          return value
        else
          return 0

      greatestScore = if _.max(game.get('playerHand').scores(), callback) > _.max(game.get('dealerHand').scores(), callback) then game.get('playerHand') else game.get('dealerHand')
      assert.isTrue spygame3.calledWith 'winner', greatestScore



