superagent = require 'superagent'

class Processor

  constructor: (@eventQueue, @viewMaster) ->

  execute: (request) ->

    publish = @eventQueue.publish.bind(@eventQueue)
    req     = request.create(@viewMaster.getIdentity(), superagent)

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
    document.location = "/x/login?from=expired&return=#{encodeURIComponent(document.location)}"

module.exports = Processor
