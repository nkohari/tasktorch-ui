Request = require 'data/framework/Request'

class ReactivateAccountRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/account/reactivate"))
    .withCredentials()
    .send()

  onSuccess: (result, publish) ->

module.exports = ReactivateAccountRequest
