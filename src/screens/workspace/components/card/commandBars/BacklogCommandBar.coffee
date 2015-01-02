_                     = require 'lodash'
React                 = require 'react'
PropTypes             = require 'common/PropTypes'
CardContext           = require '../CardContext'
AcceptCommandButton   = React.createFactory(require '../commandButtons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require '../commandButtons/PassCommandButton')
CompleteCommandButton = React.createFactory(require '../commandButtons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require '../commandButtons/DeleteCommandButton')
{div}                 = React.DOM

BacklogCommandBar = React.createClass {

  displayName: 'BacklogCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CardContext]

  render: ->

    div {className: 'backlog commands'}, [
      div {key: 'left', className: 'button-group'}, [
        AcceptCommandButton {key: 'accept'}
        PassCommandButton   {key: 'pass'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CompleteCommandButton {key: 'complete'}
        DeleteCommandButton   {key: 'delete'}
      ]
    ]

}

module.exports = BacklogCommandBar
