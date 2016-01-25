#--------------------------------------------------------------------------------
React                      = require 'react'
KindStatus                 = require 'data/enums/KindStatus'
UserChangedKindStatusEvent = require 'events/ui/UserChangedKindStatusEvent'
PropTypes                  = require 'ui/framework/PropTypes'
Actor                      = require 'ui/framework/mixins/Actor'
CachedState                = require 'ui/framework/mixins/CachedState'
Button                     = React.createFactory(require 'ui/common/Button')
Dialog                     = React.createFactory(require 'ui/common/Dialog')
DialogFooter               = React.createFactory(require 'ui/common/DialogFooter')
Prompt                     = React.createFactory(require 'ui/common/Prompt')
#--------------------------------------------------------------------------------

ChangeKindStatusDialog = React.createClass {

  displayName: 'ChangeKindStatusDialog'

  propTypes:
    kindid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.kindid)
  }

  render: ->

    if @state.kind?.status == KindStatus.Normal
      icon   = 'archive'
      prompt = Prompt {hint: 'archive-kind'}, 'Are you sure you want to archive this kind?'
      action = 'Archive'
    else
      icon   = 'restore'
      prompt = Prompt {hint: 'restore-kind'}, 'Are you sure you want to restore this kind?'
      action = 'Restore'

    footer = DialogFooter {
      right: [
        Button {text: "#{action} Kind", onClick: @changeKindStatus}
        Button {text: 'Cancel',         onClick: @props.closeDialog}
      ]
    }

    Dialog {icon, title: "#{action} #{@state.kind?.name}", footer, closeDialog: @props.closeDialog},
      prompt

  changeKindStatus: ->
    status = if @state.kind.status == KindStatus.Normal then KindStatus.Archived else KindStatus.Normal
    @publish new UserChangedKindStatusEvent(@props.kindid, status)
    @props.closeDialog()

}

module.exports = ChangeKindStatusDialog
