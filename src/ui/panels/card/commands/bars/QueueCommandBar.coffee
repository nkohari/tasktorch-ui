_                     = require 'lodash'
React                 = require 'react'
CardContext           = require 'ui/panels/card/CardContext'
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DelayCommandButton    = React.createFactory(require 'ui/panels/card/commands/buttons/DelayCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
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
