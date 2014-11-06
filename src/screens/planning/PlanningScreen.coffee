_                   = require 'lodash'
React               = require 'react'
Router              = require 'react-router'
ActiveUrl           = require 'mixins/ActiveUrl'
Flux                = require 'mixins/Flux'
PlanningEnvironment = require './PlanningEnvironment'
PlanningUrl         = require './PlanningUrl'
PlanningSidebar     = React.createFactory(require './components/PlanningSidebar')
{div}               = React.DOM

PlanningScreen = React.createClass {

  displayName: 'PlanningScreen'

  mixins: [
    Flux()
    ActiveUrl(PlanningUrl)
  ]

  getDefaultProps: ->
    {controller: PlanningEnvironment.createController()}

  componentWillMount: ->
    @getController().setOrganization(@getActiveUrl().organizationId)

  render: ->
    div {className: 'planning screen'}, [
      PlanningSidebar {key: 'sidebar'}
    ]

}

module.exports = PlanningScreen
