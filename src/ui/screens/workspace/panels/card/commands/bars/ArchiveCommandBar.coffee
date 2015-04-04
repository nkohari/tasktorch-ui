_                    = require 'lodash'
React                = require 'react'
mergeClasses         = require 'common/util/mergeClasses'
PropTypes            = require 'ui/framework/PropTypes'
RestoreCommandButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/RestoreCommandButton')
DeleteCommandButton  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/DeleteCommandButton')
{div}                = React.DOM

ArchiveCommandBar = React.createClass {

  displayName: 'ArchiveCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: mergeClasses('archive', @props.className)},
      div {className: 'button-group'},
        RestoreCommandButton {card: @props.card}
      div {className: 'button-group right'},
        DeleteCommandButton {card: @props.card}

}

module.exports = ArchiveCommandBar
