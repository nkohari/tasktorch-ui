_       = require 'lodash'
React   = require 'react'
Observe = require 'mixins/Observe'
{div}   = React.DOM

StrategyScreen = React.createClass {

  displayName: 'StrategyScreen'

  mixins: [
    Observe()
  ]

  render: ->
    div {className: 'strategy screen'}, [
    ]

}

module.exports = StrategyScreen
