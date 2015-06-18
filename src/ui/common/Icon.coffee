#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{i}        = React.DOM
#--------------------------------------------------------------------------------
require './Icon.styl'
#--------------------------------------------------------------------------------

Icon = React.createClass {

  displayName: 'Icon'

  propTypes:
    name:  PropTypes.string
    color: PropTypes.string

  render: ->

    classes = classSet [
      "icon-#{@props.name}"
      @props.color.toLowerCase() if @props.color?
    ]

    props = mergeProps _.omit(@props, 'name'), {
      className: classes
    }

    i props, @props.children

}

module.exports = Icon
