_          = require 'lodash'
React      = require 'react'
Flux       = require '../mixins/Flux'
UserWidget = React.createFactory(require './UserWidget')
{div}      = React.DOM

PresenceBar = React.createClass {

  displayName: 'PresenceBar'
  
  mixins: [
    Flux('users')
  ]

  getStateFromStores: (stores) ->
    {connectedUsers: stores.users.getConnectedUsers()}

  render: ->
    users = _.map @state.connectedUsers, (user) -> UserWidget {key: "user-#{user.id}", user}
    div {className: 'presence'}, users

}

module.exports = PresenceBar
