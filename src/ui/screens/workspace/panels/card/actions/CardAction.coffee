React                   = require 'react'
classSet                = require 'common/util/classSet'
PropTypes               = require 'ui/framework/PropTypes'
Icon                    = React.createFactory(require 'ui/common/Icon')
CardActionStatus        = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionStatus')
CardActionOwner         = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionOwner')
CardActionText          = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionText')
CardActionDeleteTrigger = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionDeleteTrigger')
{div}                   = React.DOM

CardAction = React.createClass {

  displayName: 'CardAction'

  propTypes:
    action: PropTypes.Action

  render: ->

    classes = classSet [
      'action'
      @props.action.status.toLowerCase()
    ]

    div {className: classes},
      div {className: 'left-controls'},
        Icon {name: 'handle'}
      CardActionStatus {action: @props.action}
      CardActionOwner  {action: @props.action}
      CardActionText   {action: @props.action}
      div {className: 'right-controls'},
        CardActionDeleteTrigger {action: @props.action}

}

module.exports = CardAction
