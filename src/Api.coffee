request = require 'superagent'

noop = (->)

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
    request.get "/api/#{organizationId}/cards/#{cardId}?expand=type", (res) =>
      callback(null, res.body)

  setCardBody: (card, body) ->
    request.post("#{card.uri}/body").send({body}).end()

  setCardTitle: (card, title) ->
    request.post("#{card.uri}/title").send({title}).end()

module.exports = new Api()
