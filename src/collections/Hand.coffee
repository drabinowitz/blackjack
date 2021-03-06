class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    isOver = _(do @scores).every (score) -> score > 21
    if not isOver
      temp = @deck.pop()
      @add(temp)
    isOver = _(do @scores).every (score) -> score > 21
    if isOver then @trigger 'over21',@
    temp

  hasAce: -> @reduce (memo, card) ->
    memo or (card.get('value') is 1 and card.get('revealed'))
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    #test
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    @trigger 'stand', @

  reveal: ->
    @forEach (card) ->
      if !card.get('revealed') then do card.flip

