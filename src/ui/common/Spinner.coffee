#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{span}     = React.DOM
#--------------------------------------------------------------------------------
require './Spinner.styl'
#--------------------------------------------------------------------------------

Spinner = React.createClass {

  displayName: 'Spinner'

  propTypes:
    size:      PropTypes.number
    thickness: PropTypes.number

  getDefaultProps: -> {
    size:      16
    thickness: 3
  }

  render: ->

    style =
      height:      @props.size
      width:       @props.size
      borderWidth: @props.thickness

    props = mergeProps _.omit(@props, 'size', 'thickness'), {
      className: 'spinner'
      style
    }

    span props, @props.children

}

module.exports = Spinner
