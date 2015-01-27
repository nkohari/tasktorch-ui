superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionChangedEvent = require 'events/change/ActionChangedEvent'

class DeleteActionRequest extends Request

  constructor: (@action) ->

  execute: ->
    superagent.del("/api/#{@action.org}/actions/#{@action.id}")
    .end()

module.exports = DeleteActionRequest
