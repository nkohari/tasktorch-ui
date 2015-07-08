#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
CachedState             = require 'ui/framework/mixins/CachedState'
Button                  = React.createFactory(require 'ui/common/Button')
Dialog                  = React.createFactory(require 'ui/common/Dialog')
DialogFooter            = React.createFactory(require 'ui/common/DialogFooter')
Prompt                  = React.createFactory(require 'ui/common/Prompt')
ChangeKindWorkflowStage = React.createFactory(require 'ui/dialogs/changeKindWorkflow/ChangeKindWorkflowStage')
{a, div, ul}            = React.DOM
#--------------------------------------------------------------------------------
require './ChangeKindWorkflowDialog.styl'
#--------------------------------------------------------------------------------

ChangeKindWorkflowDialog = React.createClass {

  displayEmail: 'ChangeKindWorkflowDialog'

  propTypes:
    kindid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    kind:   cache('kinds').get(@props.kindid)
    stages: cache('stagesByKind').get(@props.kindid)
  }

  render: ->

    items = _.map @state.stages, (stage, index) =>
      div {key: stage.id, className: 'section'},
        ChangeKindWorkflowStage {key: stage.id, stage}
        div {className: 'add-stage'}, 'Add another stage'

    footer = DialogFooter {
      right: Button {text: 'Done', onClick: @props.closeDialog}
    }

    Dialog {icon: 'workflow', title: "Change #{@state.kind?.name} Workflow", footer, className: 'change-kind-workflow-dialog', closeDialog: @props.closeDialog},
      Prompt {hint: 'change-kind-workflow'},
        'What process do you follow for these cards?'
      ul {className: 'stage-list'},
        items

  addStage: (index) ->

}

module.exports = ChangeKindWorkflowDialog
