_                = require 'lodash'
React            = require 'react/addons'
mergeProps       = require 'common/util/mergeProps'
PropTypes        = require 'ui/framework/PropTypes'
{div}            = React.DOM
{cloneWithProps} = React.addons

WizardPage = React.createClass {

  displayName: 'WizardPage'

  propTypes:
    title:         PropTypes.string
    isValid:       PropTypes.func
    setCanProceed: PropTypes.func

  componentDidMount: ->
    @props.setCanProceed(@props.isValid())

  componentDidUpdate: ->
    @props.setCanProceed(@props.isValid())

  render: ->

    props = mergeProps _.omit(@props, 'title', 'isValid', 'setCanProceed'), {
      className: 'wizard-page'
    }

    div props, @props.children

}

module.exports = WizardPage
