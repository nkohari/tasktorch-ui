React                 = require 'react'
CardContext           = require '../CardContext'
AcceptCommandButton   = React.createFactory(require '../commandButtons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require '../commandButtons/PassCommandButton')
DelayCommandButton    = React.createFactory(require '../commandButtons/DelayCommandButton')
CompleteCommandButton = React.createFactory(require '../commandButtons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require '../commandButtons/DeleteCommandButton')
{div}                 = React.DOM

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  mixins: [CardContext]

  render: ->

    div {className: 'inbox commands'}, [
      div {key: 'left', className: 'button-group'}, [
        AcceptCommandButton {key: 'accept'}
        PassCommandButton   {key: 'pass'}
        DelayCommandButton  {key: 'delay'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        CompleteCommandButton {key: 'complete'}
        DeleteCommandButton   {key: 'delete'}
      ]
    ]


}

module.exports = InboxCommandBar
