#--------------------------------------------------------------------------------
_                     = require 'lodash'
React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
UserDeletedStageEvent = require 'events/ui/UserDeletedStageEvent'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
Field                 = React.createFactory(require 'ui/common/Field')
Icon                  = React.createFactory(require 'ui/common/Icon')
StaticSelector        = React.createFactory(require 'ui/common/StaticSelector')
StageOption           = React.createFactory(require 'ui/options/StageOption')
{div}                 = React.DOM
#--------------------------------------------------------------------------------

DeleteStageDialog = React.createClass {

  displayName: 'DeleteStageDialog'

  propTypes:
    stageid:     PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getInitialState: ->
    {inheritorStage: undefined}

  getCachedState: (cache) ->
    stage = cache('stages').get(@props.stageid)
    if stage?
      allStages   = cache('stagesByKind').get(stage.kind)
      otherStages = _.without(allStages, stage)
    {stage, otherStages}

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Delete Stage', onClick: @deleteStage, disabled: !@isValid()}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'trash', title: "Delete #{@state.stage?.name} Stage", footer, closeDialog: @props.closeDialog},
      Field {label: 'Where would you like to move the actions from this stage?', hint: 'delete-stage'},
        StaticSelector {
          component:   StageOption
          placeholder: 'Click to select a stage'
          value:       @state.inheritorStage
          options:     @state.otherStages
          onChange:    @onStageSelected
        }

  onStageSelected: (stage) ->
    @setState {inheritorStage: stage}

  isValid: ->
    @state.inheritorStage?

  deleteStage: ->
    @publish new UserDeletedStageEvent(@props.stageid, @state.inheritorStage.id)
    @props.closeDialog()

}

module.exports = DeleteStageDialog
