#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
{div, span} = React.DOM
#--------------------------------------------------------------------------------

ProgressBarSegment = React.createClass {

  displayName: 'ProgressBarSegment'

  propTypes:
    value: PropTypes.number
    label: PropTypes.string
    total: PropTypes.number

  render: ->

    pct = Math.round(100 * (@props.value / @props.total))

    props = mergeProps _.omit(@props, 'value'), {
      className: 'progress-bar-segment'
      style:
        width: "#{pct}%"
    }

    div props,
      span {}, @props.label if @props.label?

}

module.exports = ProgressBarSegment
