React      = require 'react'
mergeProps = require 'util/mergeProps'
{span}     = React.DOM

Icon = React.createClass {

  displayName: 'Icon'

  render: ->
    props = mergeProps @props, {className: "icon icon-#{@props.name}"}
    span props, @props.children

}

module.exports = Icon
