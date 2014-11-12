_               = require 'lodash'
React           = require 'react'
Router          = require 'react-router'
ActiveUrl       = require 'mixins/ActiveUrl'
Observe         = require 'mixins/Observe'
PlanningUrl     = require './PlanningUrl'
PlanningSidebar = React.createFactory(require './components/PlanningSidebar')
{div}           = React.DOM

PlanningScreen = React.createClass {

  displayName: 'PlanningScreen'

  mixins: [
    Observe()
    ActiveUrl(PlanningUrl)
  ]

  render: ->
    div {className: 'planning screen'}, [
      PlanningSidebar {key: 'sidebar'}
    ]

}

module.exports = PlanningScreen
