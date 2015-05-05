React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Button      = React.createFactory(require 'ui/common/Button')
ColorPicker = React.createFactory(require 'ui/common/ColorPicker')
Field       = React.createFactory(require 'ui/common/Field')
Input       = React.createFactory(require 'ui/common/Input')
Prompt      = React.createFactory(require 'ui/common/Prompt')
WizardPage  = React.createFactory(require 'ui/common/WizardPage')
{div}       = React.DOM

CreateKindWizardReviewPage = React.createClass {

  displayName: 'CreateKindWizardReviewPage'

  propTypes:
    name:         PropTypes.string
    color:        PropTypes.string
    description:  PropTypes.string
    stages:       PropTypes.arrayOf(PropTypes.string)

  render: ->

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      'todo'

  isValid: ->
    true

}

module.exports = CreateKindWizardReviewPage