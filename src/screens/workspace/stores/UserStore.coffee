_     = require 'lodash'
Store = require 'framework/Store'

class UserStore extends Store

  constructor: ->
    @currentUser = undefined
    @users = {}
    @connectedUsers = []

  getUser: (id) ->
    @users[id]

  getUsers: (ids...) ->
    _.map _.flatten(ids), (id) => @users[id]

  getCurrentUser: ->
    @currentUser

  getConnectedUsers: ->
    _.clone(@connectedUsers)

  onUsersLoaded: (event) ->
    @users = _.extend @users, _.indexBy(event.users, 'id')
    @announce()

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
