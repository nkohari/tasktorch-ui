_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
ContextMenu    = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger  = React.createFactory(require 'ui/common/DialogTrigger')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')

OrgMenu = React.createClass {

  displayName: 'OrgMenu'

  propTypes:
    currentOrg: PropTypes.Org

  render: ->

    overlay = ContextMenu {},
      DialogTrigger {name: 'CreateTeam', team: @props.team},
        'Create a team'

    OverlayTrigger {className: 'org menu-button', overlay},
      Button {text: @props.currentOrg.name, caret: true}

}

module.exports = OrgMenu
