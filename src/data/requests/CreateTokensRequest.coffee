superagent = require 'superagent'
Request    = require 'data/framework/Request'

class CreateTokenRequest extends Request

  constructor: (@tokens) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/tokens"))
    .withCredentials()
    .send({@tokens})
    .end()

module.exports = CreateTokenRequest
