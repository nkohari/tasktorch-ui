_                  = require 'lodash'
SingletonListStore = require 'data/framework/SingletonListStore'

class OnlineUsersStore extends SingletonListStore

  displayName: 'OnlineUsersStore'
  name:        'onlineUsers'
  dependsOn:   'users'

  listensFor: [
    'JoinedPresenceChannel'
    'UserConnected'
    'UserDisconnected'
  ]

  load: ->

  has: (userid) ->
    _.includes(@list, userid)

  onJoinedPresenceChannel: (event) ->
    @set(_.map(event.onlineUsers, 'id'))

  onUserConnected: (event) ->
    items = _.union @list, [event.user.id]
    @set(items)

  onUserDisconnected: (event) ->
    items = _.without @list, event.user.id
    @set(items)

module.exports = OnlineUsersStore
