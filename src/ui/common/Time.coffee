moment     = require 'moment'
React      = require 'react'
mergeProps = require 'framework/util/mergeProps'
{span}     = React.DOM

Time = React.createClass {

  displayName: 'Time'

  render: ->
    props = mergeProps @props, {className: 'time'}
    span props, [moment(@props.time).calendar()]

}

module.exports = Time
