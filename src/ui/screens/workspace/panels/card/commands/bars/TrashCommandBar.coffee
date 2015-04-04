_                    = require 'lodash'
React                = require 'react'
mergeClasses         = require 'common/util/mergeClasses'
PropTypes            = require 'ui/framework/PropTypes'
RestoreCommandButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/RestoreCommandButton')
{div}                = React.DOM

TrashCommandBar = React.createClass {

  displayName: 'TrashCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: mergeClasses('trash', @props.className)},
      div {className: 'button-group'},
        RestoreCommandButton {card: @props.card}

}

module.exports = TrashCommandBar
