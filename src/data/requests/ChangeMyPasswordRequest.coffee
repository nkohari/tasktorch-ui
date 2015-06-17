superagent = require 'superagent'
Request    = require 'data/framework/Request'

class ChangeMyPasswordRequest extends Request

  constructor: (@password) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/me/password"))
    .withCredentials()
    .send {@password}
    .end()

module.exports = ChangeMyPasswordRequest
