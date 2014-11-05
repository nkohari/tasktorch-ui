_           = require 'lodash'
React       = require 'react'
Flux        = require '../../mixins/Flux'
Avatar      = React.createFactory(require '../../common/Avatar')
MenuTrigger = React.createFactory(require '../../common/MenuTrigger')
FocusedCard = React.createFactory(require './FocusedCard')
{div}       = React.DOM

UserWidget = React.createClass {

  displayName: 'UserWidget'

  mixins: [Flux('focus')]

  getStateFromStores: (stores) ->
    {focusedCard: stores.focus.getFocusedCard() ? {}}

  componentWillMount: ->
    @getController().loadMyFocus()

  render: ->

    unless @props.currentUser?
      return div {className: 'user loading'}

    div {className: 'user'}, [
      FocusedCard {key: 'focus', className: 'focused-card', focusedCard: @state.focusedCard}
      div {className: 'user-profile'}, [
        MenuTrigger {key: 'trigger'}
        Avatar {key: 'avatar', user: @props.currentUser, size: 32}
      ]
    ]

}

module.exports = UserWidget
