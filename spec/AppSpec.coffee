assert = chai.assert
spy = sinon.spy

describe 'App', ->
  app = null
  spyApp = null
  spyApp2 = null
  game = null

  beforeEach ->
    app = new App()
    spyApp = spy app, 'handleWinner'
    spyApp2 = spy app, 'gameOver'
    game = app.get('game')

  it "should listen to event winner", ->
    playerHand = game.get('playerHand')
    game.trigger 'winner', playerHand
    assert.isTrue spyApp.calledWith playerHand

  describe "betting", ->
    it "should have a starting chips count", ->
      assert.strictEqual app.get('chips'), 10

    it "should allow user to bet", ->
      assert.strictEqual app.get('bet'), 1
      do app.raiseBet
      do app.raiseBet
      assert.strictEqual app.get('bet'), 3

    it "should not allow user to bet more chips than they have", ->
      do app.raiseBet for times in [1..20]
      assert.strictEqual app.get('bet'), 10

    it "should allow user to winning or losting chips", ->
      game.trigger 'winner', game.get('dealerHand')
      assert.strictEqual app.get('chips'), 9
      do app.raiseBet
      game.trigger 'winner', app.get('game').get('playerHand')
      assert.strictEqual app.get('chips'), 11

    it "should trigger a game over event when out of chips", ->
      do app.raiseBet for times in [1..10]
      game.trigger 'winner', game.get('dealerHand')
      assert.isTrue do spyApp2.calledWith
