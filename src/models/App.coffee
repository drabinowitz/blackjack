# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'game', game = new Game()
    @set 'chips', 10
    @set 'bet', 1
    (@get 'game').on 'winner', (e) =>
      @handleWinner(e)

  handleWinner: (hand) ->
    if hand is (@get 'game').get('dealerHand')
      @set 'chips',(@get('chips') - @get 'bet')
    else
      @set 'chips',(@get('chips') + @get 'bet')
    @set('bet', 1)

    if @get('chips') is 0 then @gameOver()
    @get('game').newGame()
    hand

  gameOver: ->

  raiseBet: ->
    if  @get('bet') + 1 <= @get('chips')
      @set('bet', @get('bet') + 1)
