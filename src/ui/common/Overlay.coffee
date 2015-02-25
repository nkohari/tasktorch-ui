_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
{div}      = React.DOM

Overlay = React.createClass {

  displayName: 'Overlay'

  propTypes:
    arrow:    PropTypes.bool
    isReady:  PropTypes.func
    position: PropTypes.string

  getDefaultProps: ->
    {position: 'left'}

  render: ->

    props = mergeProps _.omit(@props, 'arrow', 'isReady', 'position'), {
      className: classSet [
        'overlay'
        @props.position
      ]
    }

    children = [
      div {className: 'arrow'} if @props.arrow
    ]

    if not @props.isReady? or @props.isReady()
      children = children.concat(@props.children)

    div props, children

}

module.exports = Overlay
