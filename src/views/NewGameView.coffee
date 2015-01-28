class window.NewGameView extends Backbone.View
  template: _.template '
    <div class="new-game-dialogue">
      <h1>Start a New Game?</h1>
      <button class="new-game">Yes</button>
    </div>
  '

  events:
    'click .new-game': ->
      @showGameView = false
      do @render
      do @model.get('game').newGame

  initialize: ->
    @model.on('gameOver', ->
      @showGameView = true
      do @render
    , @)
    do @render

  render: ->
    do @$el.children().detach
    if @showGameView
      @$el.html do @template
    else
      @$el.html ''
