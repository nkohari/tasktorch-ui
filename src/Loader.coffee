EventEmitter = require('events').EventEmitter
request      = require 'superagent'

DUMMY_ORGANIZATION_ID = 1

class Loader extends EventEmitter

  getMyStacks: (callback) ->
    request.get "/api/#{DUMMY_ORGANIZATION_ID}/my/stacks", (res) =>
      callback(null, res.body)

  getCardsInStack: (stackId, callback) ->
    request.get "/api/#{DUMMY_ORGANIZATION_ID}/stacks/#{stackId}/cards", (res) =>
      callback(null, res.body)

module.exports = new Loader()
