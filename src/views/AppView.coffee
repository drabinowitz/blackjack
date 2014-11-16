class window.AppView extends Backbone.View
  template: _.template '
    <h1>Blackjack</h1>
    <div class="bet-container"></div>
    <div class="game-container"></div>
  '

  initialize: ->
    @model.on('newGame', @render, @)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.bet-container').html new BetView(model: @model).el
    @$('.game-container').html new GameView(model: @model.get 'game').el
