_                  = require 'lodash'
superagent         = require 'superagent'
Request            = require 'framework/Request'
ActionsLoadedEvent = require 'events/ActionsLoadedEvent'

class LoadActionsByCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}/actions", (res) =>
      {actions} = res.body
      eventBus.publish new ActionsLoadedEvent(actions)

module.exports = LoadActionsByCardRequest
