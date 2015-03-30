_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
ContextMenu   = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger = React.createFactory(require 'ui/common/DialogTrigger')
{div}         = React.DOM

TeamContextMenu = React.createClass {

  displayName: 'TeamContextMenu'

  propTypes:
    team: PropTypes.Team
    hide: PropTypes.func

  render: ->

    ContextMenu {hide: @props.hide},
      DialogTrigger {name: 'TeamSettings', team: @props.team},
        'Team settings'
      DialogTrigger {name: 'TeamMembers', team: @props.team},
        'Add or manage members'

}

module.exports = TeamContextMenu
