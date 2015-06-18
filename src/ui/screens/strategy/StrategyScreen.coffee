#--------------------------------------------------------------------------------
_     = require 'lodash'
React = require 'react'
Screen = React.createFactory(require 'ui/common/Screen')
#--------------------------------------------------------------------------------

StrategyScreen = React.createClass {

  displayName: 'StrategyScreen'

  render: ->

    Screen {className: 'strategy'},
      "Not yet implemented"

}

module.exports = StrategyScreen
