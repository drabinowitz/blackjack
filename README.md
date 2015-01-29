#blackjack
A modular application built on Backbone.js and written in CoffeeScript

The app JS is contained within the src folder.

The HTML content is rendered via Backbone view templates which are contained within the views folder.

The Backbone models are only for the App, Card, and Game. Everything else is managed via collections:

A Deck collection of cards manages the deck of cards.

Hand collections of cards manages the player hands and the actions for hitting and standing.

By leveraging this design the app is extremely easy to reason about and portions of the app can be segmented off and tested/refactored separately.
