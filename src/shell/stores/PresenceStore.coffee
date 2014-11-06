_     = require 'lodash'
Store = require 'framework/Store'

class PresenceStore extends Store

  constructor: ->
    @currentUser = undefined
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

  onCurrentUserLoaded: (event) ->
    @currentUser = event.user
    @announce()
    
module.exports = PresenceStore
