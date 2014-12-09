_                      = require 'lodash'
async                  = require 'async'
superagent             = require 'superagent'
Request                = require 'framework/Request'
SuggestionsLoadedEvent = require 'events/SuggestionsLoadedEvent'

class LoadRecipientSuggestionsRequest extends Request

  constructor: (@phrase) ->

  execute: (context, eventBus) ->
    async.parallel [
      (cb) => @loadUsers(context, cb)
      (cb) => @loadTeams(context, cb)
    ], (err, [users, teams]) =>
      eventBus.publish new SuggestionsLoadedEvent(@phrase, {users, teams})

  loadUsers: (context, callback) ->
    superagent.get "/api/#{context.organizationId}/members?suggest=#{@phrase}", (res) =>
      {users} = res.body
      callback(null, users)

  loadTeams: (context, callback) ->
    superagent.get "/api/#{context.organizationId}/teams?suggest=#{@phrase}", (res) =>
      {teams} = res.body
      callback(null, teams)

module.exports = LoadRecipientSuggestionsRequest
