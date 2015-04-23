_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
ShellContext   = require 'ui/framework/mixins/ShellContext'
Button         = React.createFactory(require 'ui/common/Button')
ContextMenu    = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger  = React.createFactory(require 'ui/common/DialogTrigger')
Icon           = React.createFactory(require 'ui/common/Icon')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  mixins: [ShellContext]

  render: ->

    overlay = ContextMenu {position: 'right'},
      DialogTrigger {name: 'CreateTeam', team: @props.team},
        Icon {name: 'team'}
        'Create a team'

    OverlayTrigger {className: 'org menu-button', overlay},
      Button {text: @getCurrentOrg().name, caret: true}

}

module.exports = OrgContextMenu
