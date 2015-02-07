request = require 'superagent'

noop = (->)

# TODO: Nuke this once we fix up the LoginScreen.
class Api

  createSession: (login, password, callback) ->
    request.post('/api/sessions').send({login, password}).end(callback)

  getMyOrgs: (callback) ->
    request.get "/api/my/orgs", callback

  getMyWorkspace: (orgid, callback) ->
    request.get "/api/#{orgid}/my/workspace", callback

  getMyStacks: (orgid, callback) ->
    request.get "/api/#{orgid}/my/stacks", (res) =>
      callback(null, res.body)

  getStack: (orgid, stackid, callback) ->
    request.get "/api/#{orgid}/stacks/#{stackid}?expand=cards", (res) =>
      callback(null, res.body)

  getCard: (orgid, cardid, callback) ->
    request.get "/api/#{orgid}/cards/#{cardid}?expand=type", (res) =>
      callback(null, res.body)

module.exports = new Api()
