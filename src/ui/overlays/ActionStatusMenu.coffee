#--------------------------------------------------------------------------------
_                            = require 'lodash'
React                        = require 'react'
UserChangedActionStatusEvent = require 'events/ui/UserChangedActionStatusEvent'
UserDeletedActionEvent       = require 'events/ui/UserDeletedActionEvent'
PropTypes                    = require 'ui/framework/PropTypes'
Actor                        = require 'ui/framework/mixins/Actor'
ActionStatus                 = require 'data/enums/ActionStatus'
ContextMenu                  = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator         = React.createFactory(require 'ui/common/ContextMenuSeparator')
Icon                         = React.createFactory(require 'ui/common/Icon')
MenuOption                   = React.createFactory(require 'ui/common/MenuOption')
{a}                          = React.DOM
#--------------------------------------------------------------------------------

ActionStatusMenu = React.createClass {

  displayName: 'ActionStatusMenu'

  propTypes:
    action:      PropTypes.Action
    hideOverlay: PropTypes.func

  mixins: [Actor]

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      MenuOption {onActivated: @changeActionStatus.bind(this, ActionStatus.NotStarted)},
        Icon {name: 'notstarted'}
        'Not Started'
      MenuOption {onActivated: @changeActionStatus.bind(this, ActionStatus.InProgress)},
        Icon {name: 'inprogress'}
        'In Progress'
      MenuOption {onActivated: @changeActionStatus.bind(this, ActionStatus.Complete)},
        Icon {name: 'complete'}
        'Complete'
      MenuOption {onActivated: @changeActionStatus.bind(this, ActionStatus.Warning)},
        Icon {name: 'warning'}
        'Warning'
      ContextMenuSeparator {}
      MenuOption {onActivated: @deleteAction},
        Icon {name: 'trash'}
        'Delete'

  changeActionStatus: (status) ->
    if @props.action.status != status
      @publish new UserChangedActionStatusEvent(@props.action.id, status)
    @props.hideOverlay()

  deleteAction: ->
    @publish new UserDeletedActionEvent(@props.action.id)
    @props.hideOverlay()

}

module.exports = ActionStatusMenu
