Request = require 'data/framework/Request'

class CreateTokenRequest extends Request

  constructor: (@tokens) ->

  create: (agent) ->
    agent
    .post(@urlFor("/tokens"))
    .withCredentials()
    .send {@tokens}

  onSuccess: (result, publish) ->

module.exports = CreateTokenRequest
