React      = require 'react'
mergeProps = require 'common/util/mergeProps'
{div}      = React.DOM

TooltipOverlay = React.createClass {

  displayName: 'TooltipOverlay'

  render: ->

    props = mergeProps @props, {
      className: "overlay #{@props.placement}"
      style: {left: @props.position.left, top: @props.position.top}
    }

    div props,
      div {className: 'arrow'}
      div {className: 'content'}, @props.text

}

module.exports = TooltipOverlay
