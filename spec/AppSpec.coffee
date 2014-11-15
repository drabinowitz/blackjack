assert = chai.assert
spy = sinon.spy

describe 'App event handler', ->
  app = null
  spyApp = null
  spyApp2 = null

  beforeEach ->
    app = new App()
    spyApp = spy app, 'handleHand'
    spyApp2 = spy app, 'handleStand'

  it "should listen to player or dealer going over 21", ->
    app.get('playerHand').trigger 'over21', app.get 'playerHand'
    assert.isTrue spyApp.calledWith app.get 'playerHand'

  it "should declare player or dealer is the winner", ->
    assert.strictEqual app.handleHand(app.get('playerHand')), app.get('dealerHand')
    assert.strictEqual app.handleHand(app.get('dealerHand')), app.get('playerHand')

  it "should listen to player or dealer stand", ->
    app.get('playerHand').trigger 'stand', app.get 'playerHand'
    assert.isTrue spyApp2.calledWith app.get 'playerHand'

  describe 'handle stand', ->
    it "should determine a winner if the dealer stand", ->
      callback = (value) -> 
        if value <= 21
          return value
        else
          return 0

      greatestScore = if _.max(app.get('playerHand').scores(), callback) > _.max(app.get('dealerHand').scores(), callback) then app.get('playerHand') else app.get('dealerHand')
      assert.strictEqual app.handleStand(app.get('dealerHand')), greatestScore

    describe "dealer play", ->
      it "keeps hitting until their score greater than player or over 21", ->
        do app.dealerPlay
        assert.isTrue _.max(app.get('playerHand').scores()) <= _.max(app.get('dealerHand').scores())