assert = chai.assert
spy = sinon.spy

describe 'hand', ->
  deck = null
  hand = null
  spyHand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    spyHand = spy hand, 'trigger'

  describe 'score', ->
    it 'should keep track of scores when score goes over', ->
      do hand.hit for times in [1..20]
      assert.isTrue spyHand.calledWith 'over21', hand 