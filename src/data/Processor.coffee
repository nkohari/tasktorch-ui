superagent = require 'superagent'

class Processor

  constructor: (@eventQueue) ->

  execute: (request) ->

    publish = @eventQueue.publish.bind(@eventQueue)
    req     = request.create(superagent)

    req.end (err, res) =>
      if res.ok
        request.onSuccess(res.body, publish)
      else if res.forbidden
        request.onForbidden(publish)
      else if res.notFound
        request.onNotFound(publish)
      else if res.serverError
        request.onError(publish)
      else if res.unauthorized
        @handleUnauthorized()

  handleUnauthorized: ->
    # TODO: This is kind of ham-handed. Any better way to redirect?
    document.location = '/x/login'

module.exports = Processor
