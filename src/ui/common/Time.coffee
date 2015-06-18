#--------------------------------------------------------------------------------
moment     = require 'moment'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{time}     = React.DOM
#--------------------------------------------------------------------------------

Time = React.createClass {

  displayName: 'Time'

  propTypes:
    time:     PropTypes.oneOfType [PropTypes.string, PropTypes.instanceOf(Date)]
    format:   PropTypes.string
    relative: PropTypes.bool

  getDefaultProps: ->
    {relative: false}

  render: ->

    value = moment(@props.time)

    if @props.relative
      text = value.fromNow()
    else if @props.format?
      text = value.format(@props.format)
    else
      text = value.calendar()

    props = mergeProps @props, {
      dateTime: value.toISOString()
      title:    value.format('dddd, MMMM Do YYYY, h:mm:ss a')
    }

    time props, text

}

module.exports = Time
