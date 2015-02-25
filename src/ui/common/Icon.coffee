_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
mergeProps = require 'common/util/mergeProps'
{span}     = React.DOM

Icon = React.createClass {

  displayName: 'Icon'

  propTypes:
    name: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'name'), {
      className: "icon icon-#{@props.name}"
    }

    span props, @props.children

}

module.exports = Icon
