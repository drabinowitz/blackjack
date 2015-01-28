class window.AppView extends Backbone.View
  template: _.template '
    <h1>Blackjack</h1>
    <div class="new-game-container"></div>
    <div class="bet-container"></div>
    <div class="game-container"></div>
  '

  initialize: ->
    @model.on('newGame', @render, @)
    do @render

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.new-game-container').html  new NewGameView(model: @model).el
    @$('.bet-container').html new BetView(model: @model).el
    @$('.game-container').html new GameView(model: @model.get 'game').el
