#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
mergeClasses         = require 'common/util/mergeClasses'
PropTypes            = require 'ui/framework/PropTypes'
AcceptCommandButton  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/PassCommandButton')
DeleteCommandButton  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/DeleteCommandButton')
CommentCommandButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommentCommandButton')
{div}                = React.DOM
#--------------------------------------------------------------------------------

DraftsCommandBar = React.createClass {

  displayName: 'DraftsCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: mergeClasses('drafts', @props.className)},
      div {className: 'button-group'},
        AcceptCommandButton {card: @props.card}
        PassCommandButton {card: @props.card}
      div {className: 'button-group'},
        CommentCommandButton {card: @props.card}
      div {className: 'button-group right'},
        DeleteCommandButton {card: @props.card}

}

module.exports = DraftsCommandBar
