_                      = require 'lodash'
async                  = require 'async'
superagent             = require 'superagent'
Request                = require 'framework/Request'
SuggestionsLoadedEvent = require 'events/load/SuggestionsLoadedEvent'

class LoadRecipientSuggestionsRequest extends Request

  constructor: (@phrase) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/members?suggest=#{@phrase}", (res) =>
      {users} = res.body
      eventBus.publish new SuggestionsLoadedEvent(@phrase, {users, teams: []})

module.exports = LoadRecipientSuggestionsRequest
