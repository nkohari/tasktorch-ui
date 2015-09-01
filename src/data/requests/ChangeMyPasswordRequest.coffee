Request = require 'data/framework/Request'

class ChangeMyPasswordRequest extends Request

  constructor: (@password) ->

  create: (agent) ->
    agent
    .post(@urlFor("/me/password"))
    .withCredentials()
    .send {@password}

  onSuccess: (result, publish) ->

module.exports = ChangeMyPasswordRequest
