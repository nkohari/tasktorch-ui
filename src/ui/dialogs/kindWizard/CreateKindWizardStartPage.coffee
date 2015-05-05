_                = require 'lodash'
React            = require 'react'
classSet         = require 'common/util/classSet'
PropTypes        = require 'ui/framework/PropTypes'
Field            = React.createFactory(require 'ui/common/Field')
Radio            = React.createFactory(require 'ui/common/Radio')
WizardPage       = React.createFactory(require 'ui/common/WizardPage')
KindTemplateList = React.createFactory(require 'ui/dialogs/kindWizard/KindTemplateList')
{div}            = React.DOM

CreateKindWizardStartPage = React.createClass {

  displayName: 'CreateKindWizardStartPage'

  propTypes:
    mode:          PropTypes.string
    template:      PropTypes.object
    setTemplate:   PropTypes.func
    setValue:      PropTypes.func
    setCanProceed: PropTypes.func

  render: ->

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      Field {},
        Radio {name: 'mode', text: 'Create a custom card kind', value: 'custom', checked: @props.mode is 'custom', onChange: @onModeChanged}
      Field {expand: true},
        Radio {name: 'mode', text: 'Begin with a template', value: 'template', checked: @props.mode is 'template', onChange: @onModeChanged}
        KindTemplateList {value: @props.template, disabled: @props.mode isnt 'template', onChange: @onTemplateChanged}

  isValid: ->
    @props.mode is 'custom' or (@props.mode is 'template' and @props.template?)

  onTemplateChanged: (template) ->
    @props.setTemplate(template)

  onModeChanged: (event) ->
    mode = event.target.value
    @props.setValue('mode', mode)
    @props.setTemplate(undefined) if mode == 'custom'

}

module.exports = CreateKindWizardStartPage