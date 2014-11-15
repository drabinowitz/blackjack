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
    callback = (value) -> 
      if value <= 21
        return value
      else
        return 0

    if hand is @get('dealerHand')
      if _.max(@get('playerHand').scores(), callback) > _.max(@get('dealerHand').scores(), callback) 
        return @get('playerHand')  
      else 
        return @get('dealerHand')
    else
      do @dealerPlay

  dealerPlay: () ->
    # call hand method reveal
    # while max of dealer hand score is less than max of player score

      

      # check to see who stands
      # if it is the playwer who stands
        # call methods 
        # flips whatever cards not flip over
        # start picking hit
        # on hit 
          # check if it is greater than

      # if dealer stand
        # compare score
          # return the winner

      # if dealer stand
        # compare score
          # return the winner

# if _.max(@get('playerHand').scores())
#  > _.max(app.get('dealerHand').scores()) 
#  then app.get('playerHand') 
#  else app.get('dealerHand')