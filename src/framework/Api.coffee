request = require 'superagent'

noop = (->)

# TODO: Nuke this once we fix up the LoginScreen.
class Api

  createSession: (login, password, callback) ->
    request.post('/api/sessions').send({login, password}).end(callback)

  getMyOrgs: (callback) ->
    request.get "/api/my/orgs", callback

  getMyWorkspace: (orgId, callback) ->
    request.get "/api/#{orgId}/my/workspace", callback

  getMyStacks: (orgId, callback) ->
    request.get "/api/#{orgId}/my/stacks", (res) =>
      callback(null, res.body)

  getStack: (orgId, stackId, callback) ->
    request.get "/api/#{orgId}/stacks/#{stackId}?expand=cards", (res) =>
      callback(null, res.body)

  getCard: (orgId, cardId, callback) ->
    request.get "/api/#{orgId}/cards/#{cardId}?expand=type", (res) =>
      callback(null, res.body)

module.exports = new Api()
