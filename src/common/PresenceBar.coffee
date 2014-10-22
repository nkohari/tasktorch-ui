_          = require 'lodash'
React      = require 'react'
Flux       = require '../mixins/Flux'
UserWidget = require './UserWidget'
{div}      = React.DOM

PresenceBar = React.createClass {

  mixins: [
    Flux('users')
  ]

  getStateFromStores: (stores) ->
    {connectedUsers: stores.users.getConnectedUsers()}

  render: ->
    users = _.map @state.connectedUsers, (user) -> UserWidget {user}
    div {className: 'presence'}, users

}

module.exports = PresenceBar
