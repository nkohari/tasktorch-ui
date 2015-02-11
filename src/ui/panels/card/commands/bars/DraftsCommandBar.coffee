_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardContext         = require 'ui/panels/card/CardContext'
AcceptCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DeleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}               = React.DOM

DraftsCommandBar = React.createClass {

  displayName: 'DraftsCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CardContext]

  render: ->

    div {className: 'queue commands'}, [
      div {key: 'left', className: 'button-group'}, [
        AcceptCommandButton {key: 'accept'}
        PassCommandButton   {key: 'pass'}
      ]
      div {key: 'right', className: 'button-group right'}, [
        DeleteCommandButton {key: 'delete'}
      ]
    ]

}

module.exports = DraftsCommandBar
