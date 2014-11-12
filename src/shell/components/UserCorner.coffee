_           = require 'lodash'
React       = require 'react'
Observe     = require 'mixins/Observe'
Avatar      = React.createFactory(require 'common/Avatar')
MenuTrigger = React.createFactory(require 'common/MenuTrigger')
FocusedCard = React.createFactory(require './FocusedCard')
{div}       = React.DOM

UserCorner = React.createClass {

  displayName: 'UserCorner'

  mixins: [Observe()]

  render: ->

    unless @props.currentUser?
      return div {className: 'user loading'}

    div {className: 'user-corner'}, [
      FocusedCard {key: 'focus', className: 'focused-card'}
      div {key: 'user-profile', className: 'user-profile'}, [
        MenuTrigger {key: 'trigger'}
        Avatar {key: 'avatar', user: @props.currentUser, size: 32}
      ]
    ]

}

module.exports = UserCorner
