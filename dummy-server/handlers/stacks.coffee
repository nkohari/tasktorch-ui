_    = require 'lodash'
data = require '../data'

exports.register = (app) ->

  app.get '/api/stacks', (req, res) ->
    res.json _.values(data.stacks)

  app.get '/api/stacks/:id', (req, res) ->
    stack = data.stacks[req.params.id]
    if stack?
      res.json(stack)
    else
      res.status(404).end()
