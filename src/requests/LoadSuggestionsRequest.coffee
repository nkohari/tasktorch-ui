_                      = require 'lodash'
async                  = require 'async'
superagent             = require 'superagent'
Request                = require 'framework/Request'
SuggestionsLoadedEvent = require 'events/load/SuggestionsLoadedEvent'

class LoadSuggestionsRequest extends Request

  constructor: (@types, @phrase) ->

  execute: (context, eventBus) ->
    for type in @types
      switch type
        when 'user' then @getUserSuggestions(context, eventBus)
        when 'team' then @getTeamSuggestions(context, eventBus)
        else throw new Error("Don't know how to retrieve suggestions of type #{type}")

  getUserSuggestions: (context, eventBus) ->
    superagent.get "/api/#{context.orgId}/members?suggest=#{@phrase}", (res) =>
      {users} = res.body
      if users.length > 0
        eventBus.publish new SuggestionsLoadedEvent(@phrase, 'user', users)

  getTeamSuggestions: (context, eventBus) ->
    superagent.get "/api/#{context.orgId}/teams?suggest=#{@phrase}", (res) =>
      {teams} = res.body
      if teams.length > 0
        eventBus.publish new SuggestionsLoadedEvent(@phrase, 'team', teams)

module.exports = LoadSuggestionsRequest
