#--------------------------------------------------------------------------------
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Icon        = React.createFactory(require 'ui/common/Icon')
Prompt      = React.createFactory(require 'ui/common/Prompt')
WizardPage  = React.createFactory(require 'ui/common/WizardPage')
{div}       = React.DOM
#--------------------------------------------------------------------------------

CreateKindWizardReviewPage = React.createClass {

  displayName: 'CreateKindWizardReviewPage'

  propTypes:
    name:         PropTypes.string
    color:        PropTypes.string
    description:  PropTypes.string
    stages:       PropTypes.arrayOf(PropTypes.string)

  render: ->

    WizardPage {@isValid, setCanProceed: @props.setCanProceed},
      Prompt {hint: 'create-kind-review'},
        'Do you want to create this card kind?'
      div {className: 'kind-preview'},
        Icon {name: 'card', color: @props.color}
        div {className: 'kind-name'}, @props.name
        div {className: 'kind-description'}, @props.description


  isValid: ->
    true

}

module.exports = CreateKindWizardReviewPage