Request = require 'data/framework/Request'

class ChangeMyPasswordRequest extends Request

  constructor: (@password) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/me/password"))
    .withCredentials()
    .send {@password}

  onSuccess: (result, publish) ->

module.exports = ChangeMyPasswordRequest
