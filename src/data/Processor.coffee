superagent = require 'superagent'

class Processor

  constructor: (@history, @eventQueue, @viewMaster) ->
    @redirecting = false

  reset: ->
    @redirecting = false

  execute: (request) ->

    publish = @eventQueue.publish.bind(@eventQueue)
    req     = request.create(@viewMaster.getIdentity(), superagent)

    req.end (err, res) =>
      if res.ok
        request.onSuccess(res.body, publish, superagent)
      else if res.forbidden
        request.onForbidden(publish, superagent)
      else if res.notFound
        request.onNotFound(publish, superagent)
      else if res.serverError
        request.onError(publish, superagent)
      else if res.unauthorized
        @handleUnauthorized()
      else if res.status == 402
        @handlePaymentRequired()

  handleUnauthorized: ->
    unless @redirecting
      @redirecting = true
      @history.pushState(null, '/login', {from: 'expired', return: document.location.toString()})

  handlePaymentRequired: ->
    unless @redirecting
      @redirecting = true
      @history.pushState(null, '/subscription-not-found')
 
module.exports = Processor
