#--------------------------------------------------------------------------------
React            = require 'react'
classSet         = require 'common/util/classSet'
PropTypes        = require 'ui/framework/PropTypes'
Icon             = React.createFactory(require 'ui/common/Icon')
CardActionStatus = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionStatus')
CardActionOwner  = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionOwner')
CardActionText   = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionText')
{li, div}        = React.DOM
#--------------------------------------------------------------------------------
require './CardAction.styl'
#--------------------------------------------------------------------------------

CardAction = React.createClass {

  displayName: 'CardAction'

  propTypes:
    action: PropTypes.Action

  render: ->

    classes = classSet [
      'card-action'
      @props.action.status.toLowerCase()
    ]

    li {className: classes, 'data-id': @props.action.id},
      div {className: 'move-handle'}
      CardActionText   {action: @props.action}
      CardActionStatus {action: @props.action}
      CardActionOwner  {action: @props.action}

}

module.exports = CardAction
