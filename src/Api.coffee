request = require 'superagent'

class Api

  createSession: (login, password, callback) ->
    request.post('/api/sessions').send({login, password}).end(callback)

  getMyOrganizations: (callback) ->
    request.get "/api/my/organizations", callback

  getMyWorkspace: (organizationId, callback) ->
    request.get "/api/#{organizationId}/my/workspace", callback

  getMyStacks: (organizationId, callback) ->
    request.get "/api/#{organizationId}/my/stacks", (res) =>
      callback(null, res.body)

  getStack: (organizationId, stackId, callback) ->
    request.get "/api/#{organizationId}/stacks/#{stackId}?expand=cards", (res) =>
      callback(null, res.body)

  getCard: (organizationId, cardId, callback) ->
    request.get "/api/#{organizationId}/cards/#{cardId}", (res) =>
      callback(null, res.body)

module.exports = new Api()
