_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Field            = React.createFactory(require 'ui/common/Field')
WizardPage       = React.createFactory(require 'ui/common/WizardPage')
KindActionEditor = React.createFactory(require 'ui/dialogs/kindWizard/KindActionEditor')
{div, ul}        = React.DOM

CreateKindWizardWorkflowPage = React.createClass {

  displayName: 'CreateKindWizardWorkflowPage'

  propTypes:
    stages:        PropTypes.arrayOf(PropTypes.object)
    setCanProceed: PropTypes.func

  render: ->

    hint = """
      Are there some actions that you always perform when doing work of this kind?
      When someone creates a card of this kind, these actions will be added by default.
      You can drag and drop the actions to reorganize them, or move them between stages.
    """

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      Field {label: 'Define Default Actions', hint, hintPosition: 'before', expand: true},
        KindActionEditor {stages: @props.stages, @setActions, @addAction, @updateAction, @removeAction}

  isValid: ->
    true

  setStages: (stages) ->
    @props.setValue('stages', stages)

  setActions: (stageid, actions) ->
    stages = _.cloneDeep(@props.stages)
    for stage in stages
      if stage.id == stageid
        stage.defaultActions = actions
    @setStages(stages)

  addAction: (stageid, action) ->
    stages = _.cloneDeep(@props.stages)
    for stage in stages
      if stage.id == stageid
        stage.defaultActions.push(action)
    @setStages(stages)

  updateAction: (stageid, actionid, text) ->
    stages = _.cloneDeep(@props.stages)
    for stage in stages
      continue unless stage.id == stageid
      for action in stage.defaultActions
        if action.id == actionid
          action.text = text
    @setStages(stages)

  removeAction: (stageid, actionid) ->
    console.log 'hay'
    stages = _.cloneDeep(@props.stages)
    for stage in stages
      if stage.id == stageid
        stage.defaultActions = _.filter stage.defaultActions, (action) -> action.id != actionid
    @setStages(stages)

}

module.exports = CreateKindWizardWorkflowPage