React                              = require 'react'
PropTypes                          = require 'ui/framework/PropTypes'
Actor                              = require 'ui/framework/mixins/Actor'
ShellContext                       = require 'ui/framework/mixins/ShellContext'
Button                             = React.createFactory(require 'ui/common/Button')
Wizard                             = React.createFactory(require 'ui/common/Wizard')
CreateKindWizardStartPage          = React.createFactory(require 'ui/dialogs/kindWizard/CreateKindWizardStartPage')
CreateKindWizardBasicsPage         = React.createFactory(require 'ui/dialogs/kindWizard/CreateKindWizardBasicsPage')
CreateKindWizardWorkflowPage       = React.createFactory(require 'ui/dialogs/kindWizard/CreateKindWizardWorkflowPage')
CreateKindWizardDefaultActionsPage = React.createFactory(require 'ui/dialogs/kindWizard/CreateKindWizardDefaultActionsPage')
CreateKindWizardReviewPage         = React.createFactory(require 'ui/dialogs/kindWizard/CreateKindWizardReviewPage')
{div}                              = React.DOM

CreateKindWizard = React.createClass {

  displayName: 'CreateKindWizard'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor, ShellContext]

  getInitialState: -> {
    mode:        'custom'
    template:    undefined
    name:        ''
    color:       'Red'
    description: ''
    stages:      []
  }

  render: ->

    completeButton = Button {text: 'Create Kind', onClick: @createKind, disabled: !@isValid()}

    Wizard {icon: 'kind', width: 850, height: 650, title: "Define a Card Kind", completeButton, closeDialog: @props.closeDialog},
      CreateKindWizardStartPage          {title: 'Start', mode: @state.mode, template: @state.template, @setValue, @setTemplate}
      CreateKindWizardBasicsPage         {title: 'Basics', name: @state.name, description: @state.description, color: @state.color, @setValue}
      CreateKindWizardWorkflowPage       {title: 'Workflow', stages: @state.stages, @setValue}
      CreateKindWizardDefaultActionsPage {title: 'Default Actions', stages: @state.stages, @setValue}
      CreateKindWizardReviewPage         {title: 'Review'}

  isValid: ->
    false

  setTemplate: (template) ->
    if template?
      @setState {
        template
        name:        template.name
        color:       template.color
        description: template.description
        stages:      template.stages
      }
    else
      @setState(@getInitialState())

  setValue: (name, value) ->
    patch = {}
    patch[name] = value
    @setState(patch)

  createKind: ->
    @props.closeDialog()

}

module.exports = CreateKindWizard
