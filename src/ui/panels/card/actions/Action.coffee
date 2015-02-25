React               = require 'react'
classSet            = require 'common/util/classSet'
PropTypes           = require 'ui/framework/PropTypes'
Icon                = React.createFactory(require 'ui/common/Icon')
ActionStatus        = React.createFactory(require 'ui/panels/card/actions/ActionStatus')
ActionOwner         = React.createFactory(require 'ui/panels/card/actions/ActionOwner')
ActionText          = React.createFactory(require 'ui/panels/card/actions/ActionText')
ActionDeleteTrigger = React.createFactory(require 'ui/panels/card/actions/ActionDeleteTrigger')
{div}               = React.DOM

Action = React.createClass {

  displayName: 'Action'

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
      ActionStatus {action: @props.action}
      ActionOwner  {action: @props.action}
      ActionText   {action: @props.action}
      div {className: 'right-controls'},
        ActionDeleteTrigger {action: @props.action}

}

module.exports = Action
