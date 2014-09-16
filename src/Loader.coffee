EventEmitter = require('events').EventEmitter
request      = require 'superagent'

class Loader extends EventEmitter

  getAllStacks: (callback) ->
    request.get '/api/stacks', (res) =>
      callback(null, res.body)

  getCardsInStack: (stackId, callback) ->
    request.get "/api/stacks/#{stackId}/cards", (res) =>
      callback(null, res.body)

module.exports = new Loader()
