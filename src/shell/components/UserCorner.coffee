_           = require 'lodash'
React       = require 'react'
Flux        = require '../../mixins/Flux'
Avatar      = React.createFactory(require '../../common/Avatar')
MenuTrigger = React.createFactory(require '../../common/MenuTrigger')
FocusedCard = React.createFactory(require './FocusedCard')
{div}       = React.DOM

UserWidget = React.createClass {

  displayName: 'UserWidget'

  mixins: [Flux()]

  render: ->

    unless @props.currentUser?
      return div {className: 'user loading'}

    div {className: 'user'}, [
      FocusedCard {key: 'focus', className: 'focused-card'}
      div {className: 'user-profile'}, [
        MenuTrigger {key: 'trigger'}
        Avatar {key: 'avatar', user: @props.currentUser, size: 32}
      ]
    ]

}

module.exports = UserWidget
