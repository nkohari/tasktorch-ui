_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
Field           = React.createFactory(require 'ui/common/Field')
WizardPage      = React.createFactory(require 'ui/common/WizardPage')
KindStageEditor = React.createFactory(require 'ui/dialogs/kindWizard/KindStageEditor')
{div}           = React.DOM

CreateKindWizardWorkflowPage = React.createClass {

  displayName: 'CreateKindWizardWorkflowPage'

  propTypes:
    stages:        PropTypes.arrayOf(PropTypes.object)
    setValue:      PropTypes.func
    setCanProceed: PropTypes.func

  componentDidMount: ->
    @refs.editor.focus()

  render: ->

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      Field {label: 'Define Stages of Work', hint: 'create-kind-workflow', hintPosition: 'before', expand: true},
        KindStageEditor {ref: 'editor', stages: @props.stages, @setStages, @addStage, @updateStage, @removeStage}

  isValid: ->
    @props.stages.length > 0

  setStages: (stages) ->
    @props.setValue('stages', stages)

  updateStage: (id, name) ->
    stages = _.clone(@props.stages)
    for stage in stages
      if stage.id == id
        stage.name = name
        break
    @setStages(stages)

  addStage: (stage) ->
    stages = _.clone(@props.stages)
    stages.push(stage)
    @setStages(stages)

  removeStage: (id) ->
    stages = _.filter @props.stages, (stage) -> stage.id != id
    @setStages(stages)

}

module.exports = CreateKindWizardWorkflowPage