assert = chai.assert
spy = sinon.spy

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    spy hand, 'trigger'

  describe 'score', ->
    it 'should keep track of scores when score goes over', ->
      assert.isTrue spy.calledWith 'over21', hand 