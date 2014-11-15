# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # on 'over21' event
    (@get 'playerHand').on 'over21', (e) =>
      @handleHand(e)
    # on 'stand' event
    (@get 'playerHand').on 'stand', (e) =>
      @handleStand(e)
    (@get 'dealerHand').on 'over21', (e) =>
      @handleHand(e)
    (@get 'dealerHand').on 'stand', (e) =>
      @handleStand(e)

  handleHand: (hand) ->
    # look at hand passed in
    if hand is @get('playerHand') then result = @get('dealerHand')
    # alert who wins
    if hand is @get('dealerHand') then result = @get('playerHand')
    result

  handleStand: (hand) ->
    if hand is @get('dealerHand')
      result = if do @playerIsWinning then @get('playerHand') else @get('dealerHand')
      return result
    else
      do @dealerPlay

  playerIsWinning: ->
    callback = (value) ->
      if value <= 21
        return value
      else
        return 0

    _.max(@get('playerHand').scores(), callback) > _.max(@get('dealerHand').scores(), callback)

  dealerPlay: ->
    hand = @get('dealerHand')
    hand.reveal()
    while do @playerIsWinning
      do hand.hit
    do hand.stand
