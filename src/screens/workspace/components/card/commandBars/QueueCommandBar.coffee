_                     = require 'lodash'
React                 = require 'react'
CardContext           = require '../CardContext'
PassCommandButton     = React.createFactory(require '../commandButtons/PassCommandButton')
DelayCommandButton    = React.createFactory(require '../commandButtons/DelayCommandButton')
CompleteCommandButton = React.createFactory(require '../commandButtons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require '../commandButtons/DeleteCommandButton')
{div}                 = React.DOM

QueueCommandBar = React.createClass {

  displayName: 'QueueCommandBar'

  mixins: [CardContext]

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        PassCommandButton  {key: 'pass'}
        DelayCommandButton {key: 'delay'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CompleteCommandButton {key: 'complete'}
        DeleteCommandButton   {key: 'delete'}
      ]
    ]

}

module.exports = QueueCommandBar
