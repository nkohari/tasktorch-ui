React                 = require 'react'
CardContext           = require 'ui/panels/card/CardContext'
AcceptCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DeferCommandButton    = React.createFactory(require 'ui/panels/card/commands/buttons/DeferCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  mixins: [CardContext]

  render: ->

    div {className: 'inbox commands'},
      div {className: 'button-group'},
        AcceptCommandButton {}
        PassCommandButton {}
        DeferCommandButton {}
      div {className: 'button-group right'},
        CompleteCommandButton {}
        DeleteCommandButton {}

}

module.exports = InboxCommandBar
