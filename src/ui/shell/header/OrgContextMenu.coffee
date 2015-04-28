React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
ShellContext  = require 'ui/framework/mixins/ShellContext'
ContextMenu   = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger = React.createFactory(require 'ui/common/DialogTrigger')
Icon          = React.createFactory(require 'ui/common/Icon')

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  mixins: [ShellContext]

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'CreateTeam', team: @props.team},
        Icon {name: 'team'}
        'Create a team'

}

module.exports = OrgContextMenu
