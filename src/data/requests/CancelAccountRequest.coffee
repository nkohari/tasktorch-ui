Request = require 'data/framework/Request'

class CancelAccountRequest extends Request

  constructor: (@orgid, @reason) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/account/cancel"))
    .withCredentials()
    .send {reason: @reason}

  onSuccess: (result, publish) ->

module.exports = CancelAccountRequest
