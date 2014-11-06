_     = require 'lodash'
Store = require 'framework/Store'

class UserStore extends Store

  constructor: ->
    @currentUser = undefined
    @users = {}
    @connectedUsers = []

  getConnectedUsers: ->
    _.clone(@connectedUsers)

  onJoinedPresenceChannel: (event) ->
    @connectedUsers = event.connectedUsers
    @announce()

  onUserConnected: (event) ->
    @connectedUsers.push(event.user)
    @announce()

  onUserDisconnected: (event) ->
    @connectedUsers = _.filter @connectedUsers, (u) -> u.id != event.user.id
    @announce()

  onWorkspaceLoaded: (event) ->
    @currentUser = event.workspace.user
    @announce()

module.exports = UserStore
