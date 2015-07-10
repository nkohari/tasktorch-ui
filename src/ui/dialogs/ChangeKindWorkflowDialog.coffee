#--------------------------------------------------------------------------------
_                           = require 'lodash'
React                       = require 'react'
PropTypes                   = require 'ui/framework/PropTypes'
CachedState                 = require 'ui/framework/mixins/CachedState'
Button                      = React.createFactory(require 'ui/common/Button')
Dialog                      = React.createFactory(require 'ui/common/Dialog')
DialogFooter                = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger               = React.createFactory(require 'ui/common/DialogTrigger')
Prompt                      = React.createFactory(require 'ui/common/Prompt')
ChangeKindWorkflowStageList = React.createFactory(require 'ui/dialogs/changeKindWorkflow/ChangeKindWorkflowStageList')
{div}                       = React.DOM
#--------------------------------------------------------------------------------

ChangeKindWorkflowDialog = React.createClass {

  displayEmail: 'ChangeKindWorkflowDialog'

  propTypes:
    kindid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) -> {
    kind:   cache('kinds').get(@props.kindid)
    stages: cache('stagesByKind').get(@props.kindid)
  }

  render: ->

    footer = DialogFooter {
      left: DialogTrigger {name: 'CreateStage', kindid: @props.kindid},
        Button {text: 'Add another stage'}
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'workflow', title: "Change workflow of #{@state.kind?.name}", footer, className: 'change-kind-workflow-dialog', closeDialog: @props.closeDialog},
      Prompt {hint: 'change-kind-workflow'},
        "What process do you follow for #{@state.kind?.name} cards?"
      ChangeKindWorkflowStageList {kind: @state.kind, stages: @state.stages}

}

module.exports = ChangeKindWorkflowDialog
