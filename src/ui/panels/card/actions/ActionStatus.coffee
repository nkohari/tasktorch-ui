React         = require 'react'
PropTypes     = require 'framework/PropTypes'
Observe       = require 'framework/mixins/Observe'
ActionCommand = require 'framework/enums/ActionCommand'
Icon          = React.createFactory(require 'ui/common/Icon')
{a}           = React.DOM

ActionStatus = React.createClass {

  displayName: 'ActionStatus'

  propTypes:
    action:      PropTypes.Action
    showCommand: PropTypes.func

  mixins: [Observe()]

  render: ->
    a {className: 'status', @onClick}, [
      Icon {key: 'icon', name: "action-#{@props.action.status.toLowerCase()}"}
    ]

  onClick: ->
    @props.showCommand(ActionCommand.ChangeStatus)

}

module.exports = ActionStatus
