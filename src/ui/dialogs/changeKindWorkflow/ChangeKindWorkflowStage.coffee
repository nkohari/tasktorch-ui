#--------------------------------------------------------------------------------
_                                   = require 'lodash'
React                               = require 'react'
classSet                            = require 'common/util/classSet'
UserRenamedStageEvent               = require 'events/ui/UserRenamedStageEvent'
UserChangedStageDefaultActionsEvent = require 'events/ui/UserChangedStageDefaultActionsEvent'
KeyCode                             = require 'ui/framework/KeyCode'
PropTypes                           = require 'ui/framework/PropTypes'
Actor                               = require 'ui/framework/mixins/Actor'
EditableInput                       = React.createFactory(require 'ui/common/EditableInput')
EditableTextArea                    = React.createFactory(require 'ui/common/EditableTextArea')
Icon                                = React.createFactory(require 'ui/common/Icon')
RepeatableInput                     = React.createFactory(require 'ui/common/RepeatableInput')
OverlayTrigger                      = React.createFactory(require 'ui/common/OverlayTrigger')
StageContextMenu                    = React.createFactory(require 'ui/overlays/StageContextMenu')
ChangeKindWorkflowActionList        = React.createFactory(require 'ui/dialogs/changeKindWorkflow/ChangeKindWorkflowActionList')
{a, div, ul, li}                    = React.DOM
#--------------------------------------------------------------------------------
require './ChangeKindWorkflowStage.styl'
#--------------------------------------------------------------------------------

ChangeKindWorkflowStage = React.createClass {

  displayEmail: 'ChangeKindWorkflowStage'

  propTypes:
    stage: PropTypes.Stage

  mixins: [Actor]

  getInitialState: ->
    {adding: false}

  render: ->

    classes = classSet [
      'change-kind-workflow-stage'
      'dragging' if @props.dragging
    ]

    if @state.adding
      input = RepeatableInput {placeholder: "Add another #{@props.stage.name} action", onValue: @addAction, onDone: @stopAdding}

    li {className: classes, 'data-itemid': @props.stage.id},
      div {className: 'header'},
        div {className: 'stage-name'},
          Icon {className: 'drag-handle', name: 'checklist'}
          EditableInput {value: @props.stage.name, save: @renameStage}
        OverlayTrigger {overlay: StageContextMenu {stage: @props.stage, @startAdding}},
          Icon {name: 'trigger'}
      ChangeKindWorkflowActionList {stage: @props.stage}
      input

  startAdding: ->
    @setState {adding: true}

  stopAdding: ->
    @setState {adding: false}

  renameStage: (name) ->
    @publish new UserRenamedStageEvent(@props.stage.id, name)

  addAction: (text) ->
    defaultActions = @props.stage.defaultActions.concat {text}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, defaultActions)

}

module.exports = ChangeKindWorkflowStage
