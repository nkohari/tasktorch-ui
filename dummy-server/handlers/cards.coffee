_    = require 'lodash'
data = require '../data'

exports.register = (app) ->

  app.get '/api/stacks/:id/cards', (req, res) ->
    stack = data.stacks[req.params.id]
    if stack?
      cards = _.filter _.values(data.cards), (c) -> c.stack == stack.id
      res.json(cards)
    else
      res.status(404).end()

  app.get '/api/cards/:id', (req, res) ->
    card = data.cards[req.params.id]
    if card?
      res.json(card)
    else
      res.status(404).end()
