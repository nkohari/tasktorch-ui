React  = require 'react'
{span} = React.DOM

Icon = React.createClass {

  displayName: 'Icon'

  render: ->
    span {className: "icon icon-#{@props.name}"}, @props.children

}

module.exports = Icon
