_     = require 'lodash'
React = require 'react'
Flux  = require '../../mixins/Flux'
Icon  = React.createFactory(require '../../common/Icon')
{div, span} = React.DOM

PresenceWidget = React.createClass {

  displayName: 'PresenceWidget'
  
  mixins: [
    Flux('presence')
  ]

  getStateFromStores: (stores) ->
    {connectedUsers: stores.presence.getConnectedUsers()}

  render: ->
    div {className: 'presence'}, [
      Icon {key: 'presence-icon', name: 'users'}
      span {key: 'presence-count', className: 'presence-count'}, [@state.connectedUsers.length]
    ]

}

module.exports = PresenceWidget
