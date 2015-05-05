React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Button      = React.createFactory(require 'ui/common/Button')
ColorPicker = React.createFactory(require 'ui/common/ColorPicker')
Field       = React.createFactory(require 'ui/common/Field')
Input       = React.createFactory(require 'ui/common/Input')
Prompt      = React.createFactory(require 'ui/common/Prompt')
WizardPage  = React.createFactory(require 'ui/common/WizardPage')
{div}       = React.DOM

CreateKindWizardBasicsPage = React.createClass {

  displayName: 'CreateKindWizardBasicsPage'

  propTypes:
    name:          PropTypes.string
    color:         PropTypes.string
    description:   PropTypes.string
    setValue:      PropTypes.func
    setCanProceed: PropTypes.func

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      Field {label: 'Name'},
        Input {ref: 'name', placeholder: 'ex. Feature, Support Request, Interview Candidate', value: @props.name, onChange: @onInputChanged.bind(this, 'name')}
      Field {label: 'Description'},
        Input {placeholder: 'A brief description of the work that cards of this kind will describe', value: @props.description, onChange: @onInputChanged.bind(this, 'description')}
      Field {label: 'Color'},
        ColorPicker {value: @props.color, onChange: @onColorChanged}

  isValid: ->
    @props.name?.length > 0 and @props.description?.length > 0 and @props.color?

  onInputChanged: (name, event) ->
    @props.setValue(name, event.target.value)

  onColorChanged: (color) ->
    @props.setValue('color', color)

}

module.exports = CreateKindWizardBasicsPage