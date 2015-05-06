_                                  = require 'lodash'
React                              = require 'react'
UserCreatedKindEvent               = require 'events/ui/UserCreatedKindEvent'
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
      CreateKindWizardReviewPage         {title: 'Review', name: @state.name, color: @state.color, description: @state.description, stages: @state.stages}

  isValid: ->
    @state.name?.length > 0 and @state.color? and @state.stages?.length > 0

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

    # TODO: We need the ids in the UI to do tracking (for drag and drop, mainly), but
    # we have to strip them before making the request. There's probably a cleaner way
    # to do this.
    stages = _.map @state.stages, (stage) -> {
      name: stage.name
      defaultActions: stage.defaultActions.map((action) -> {text: action.text})
    }

    @publish new UserCreatedKindEvent(@getCurrentOrg().id, @state.name, @state.description, @state.color, stages)
    @props.closeDialog()

}

module.exports = CreateKindWizard
