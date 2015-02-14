_                    = require 'lodash'
React                = require 'react'
CardContext          = require 'ui/panels/card/CardContext'
RestoreCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/RestoreCommandButton')
{div}                = React.DOM

TrashCommandBar = React.createClass {

  displayName: 'TrashCommandBar'

  mixins: [CardContext]

  render: ->

    div {className: 'archive commands'},
      div {className: 'button-group'},
        RestoreCommandButton {}

}

module.exports = TrashCommandBar