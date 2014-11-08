_                         = require 'lodash'
React                     = require 'react'
Router                    = require 'react-router'
ActiveUrl                 = require 'mixins/ActiveUrl'
Flux                      = require 'mixins/Flux'
PlanningControllerFactory = require './PlanningControllerFactory'
PlanningUrl               = require './PlanningUrl'
PlanningSidebar           = React.createFactory(require './components/PlanningSidebar')
{div}                     = React.DOM

PlanningScreen = React.createClass {

  displayName: 'PlanningScreen'

  mixins: [
    Flux()
    ActiveUrl(PlanningUrl)
  ]

  createController: ->
    PlanningControllerFactory.create(@props.params.organizationId, @props.eventBus)

  render: ->
    div {className: 'planning screen'}, [
      PlanningSidebar {key: 'sidebar'}
    ]

}

module.exports = PlanningScreen
