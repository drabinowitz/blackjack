class window.BetView extends Backbone.View
  template: _.template '
    <div>Chip Count: <%= chips %>, Current Bet: <%= bet %></div>
    <button class="raise">Raise Bet</button>
  '

  events:
    'click .raise': -> @model.raiseBet()

  initialize: ->
    @model.on('change', @render, @)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
