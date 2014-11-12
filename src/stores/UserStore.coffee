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
    matches = []
    for id in _.flatten(ids)
      user = @users[id]
      return undefined unless user?
      matches.push(user)
    return matches

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

  onCurrentUserLoaded: (event) ->
    @currentUser = event.user
    @announce()

module.exports = UserStore
