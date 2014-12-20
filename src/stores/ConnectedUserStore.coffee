_     = require 'lodash'
Store = require 'framework/Store'

class ConnectedUserStore extends Store

  onJoinedPresenceChannel: (event) ->
    @add(event.connectedUsers)

  onUserConnected: (event) ->
    @add(event.user)

  onUserDisconnected: (event) ->
    @remove(event.user)
    
module.exports = ConnectedUserStore
