#--------------------------------------------------------------------------------
moment     = require 'moment-timezone'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Time       = React.createFactory(require 'ui/common/Time')
{span}     = React.DOM
#--------------------------------------------------------------------------------

DateRange = React.createClass {

  displayName: 'DateRange'

  propTypes:
    from:   PropTypes.instanceOf(Date)
    to:     PropTypes.instanceOf(Date)
    format: PropTypes.string

  render: ->

    span {className: 'date-range'},
      Time {value: @props.from, format: @props.format}
      span {className: 'date-range-divider'}, "\u2013"
      Time {value: @props.to, format: @props.format}

}

module.exports = DateRange
