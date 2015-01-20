React         = require 'react'
PropTypes     = require 'common/PropTypes'
ActionCommand = require 'framework/enums/ActionCommand'
Observe       = require 'mixins/Observe'
Icon          = React.createFactory(require 'common/Icon')
{a}           = React.DOM

ActionDeleteTrigger = React.createClass {

  displayName: 'ActionDeleteTrigger'

  propTypes:
    action:      PropTypes.Action
    showCommand: PropTypes.func

  mixins: [Observe()]

  render: ->
    a {@onClick}, [
      Icon {key: 'delete', name: 'trash'}
    ]

  onClick: ->
    @props.showCommand(ActionCommand.Delete)

}

module.exports = ActionDeleteTrigger
