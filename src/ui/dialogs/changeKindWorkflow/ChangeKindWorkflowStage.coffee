#--------------------------------------------------------------------------------
_                                   = require 'lodash'
React                               = require 'react'
UserRenamedStageEvent               = require 'events/ui/UserRenamedStageEvent'
UserChangedStageDefaultActionsEvent = require 'events/ui/UserChangedStageDefaultActionsEvent'
KeyCode                             = require 'ui/framework/KeyCode'
PropTypes                           = require 'ui/framework/PropTypes'
Actor                               = require 'ui/framework/mixins/Actor'
EditableInput                       = React.createFactory(require 'ui/common/EditableInput')
EditableTextArea                    = React.createFactory(require 'ui/common/EditableTextArea')
Icon                                = React.createFactory(require 'ui/common/Icon')
Input                               = React.createFactory(require 'ui/common/Input')
OverlayTrigger                      = React.createFactory(require 'ui/common/OverlayTrigger')
StageContextMenu                    = React.createFactory(require 'ui/overlays/StageContextMenu')
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
    {text: ''}

  render: ->

    items = _.map @props.stage.defaultActions, (action, index) =>
      li {key: index, className: 'action'},
        div {className: 'action-content'},
          EditableTextArea {value: action.text, rows: 1, save: @changeActionText.bind(this, index)}
          a {className: 'delete-action', onClick: @deleteAction.bind(this, index)},
            Icon {name: 'remove'}

    div {className: 'change-kind-workflow-stage'},
      div {className: 'header'},
        div {className: 'stage-name'},
          Icon {name: 'checklist'}
          EditableInput {value: @props.stage.name, save: @renameStage}
        OverlayTrigger {overlay: StageContextMenu {stage: @props.stage}},
          Icon {name: 'trigger'}
      ul {className: 'action-list'},
        items
      Input {className: 'add-action', value: @state.text, placeholder: "Add another #{@props.stage.name} action", @onKeyUp, @onChange}

  onKeyUp: (event) ->
    if event.which is KeyCode.RETURN and @state.text?.length > 0
      @addAction(@state.text)
      @setState {text: ''}

  onChange: (event) ->
    @setState {text: event.target.value}

  renameStage: (name) ->
    @publish new UserRenamedStageEvent(@props.stage.id, name)

  changeActionText: (index, text) ->
    defaultActions = _.clone(@props.stage.defaultActions)
    defaultActions[index].text = text
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, defaultActions)

  addAction: (text) ->
    defaultActions = @props.stage.defaultActions.concat {text}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, defaultActions)

  deleteAction: (index) ->
    defaultActions = _.clone(@props.stage.defaultActions)
    defaultActions.splice(index, 1)
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, defaultActions)

}

module.exports = ChangeKindWorkflowStage
