React                = require 'react'
Router               = require 'react-router'
PropTypes            = require 'ui/framework/PropTypes'
ShellContext         = require 'ui/framework/mixins/ShellContext'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  mixins: [ShellContext, Router.Navigation]

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'Help'},
        Icon {name: 'help'}
        'Help'
      ContextMenuSeparator {}
      DialogTrigger {name: 'CreateTeam'},
        Icon {name: 'team'}
        'Create a team'
      DialogTrigger {name: 'CreateKind'},
        Icon {name: 'kind'}
        'Define a card kind'
      ContextMenuSeparator {}
      a {onClick: @switchOrgsClicked},
        Icon {name: 'switch'}
        'Switch to another organization'

  switchOrgsClicked: ->
    @transitionTo('orglist')

}

module.exports = OrgContextMenu
