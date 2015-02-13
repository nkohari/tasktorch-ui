React         = require 'react'
PropTypes     = require 'framework/PropTypes'
ActionCommand = require 'framework/enums/ActionCommand'
Icon          = React.createFactory(require 'ui/common/Icon')
{a}           = React.DOM

ActionDeleteTrigger = React.createClass {

  displayName: 'ActionDeleteTrigger'

  propTypes:
    action:      PropTypes.Action
    showCommand: PropTypes.func

  render: ->
    a {@onClick},
      Icon {name: 'trash'}

  onClick: ->
    @props.showCommand(ActionCommand.Delete)

}

module.exports = ActionDeleteTrigger
