moment = require 'moment'
React  = require 'react'
{span} = React.DOM

Time = React.createClass {

  displayName: 'Time'

  render: ->
    span {className: 'time'}, [moment(@props.time).calendar()]

}

module.exports = Time
