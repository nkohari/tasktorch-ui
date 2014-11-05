React = require 'react'
Icon  = React.createFactory(require '../../common/Icon')
{div, span} = React.DOM

PresenceWidget = React.createClass {

  displayName: 'PresenceWidget'

  render: ->
    div {className: 'presence'}, [
      Icon {key: 'presence-icon', name: 'users'}
      span {key: 'presence-count', className: 'presence-count'}, [@props.connectedUsers.length]
    ]

}

module.exports = PresenceWidget
