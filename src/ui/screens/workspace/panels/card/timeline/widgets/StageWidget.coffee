#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{em}      = React.DOM
#--------------------------------------------------------------------------------

StageWidget = React.createClass {

  displayName: 'StageWidget'

  propTypes:
    stage: PropTypes.Stage

  render: ->
    em {className: 'stage-widget'},
      if @props.stage? then "the #{@props.stage.name} stage" or 'a deleted stage'

}

module.exports = StageWidget
