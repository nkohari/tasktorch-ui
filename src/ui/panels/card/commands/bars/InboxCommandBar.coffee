React                 = require 'react'
CardContext           = require 'ui/panels/card/CardContext'
AcceptCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DelayCommandButton    = React.createFactory(require 'ui/panels/card/commands/buttons/DelayCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
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
