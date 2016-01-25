#--------------------------------------------------------------------------------
moment     = require 'moment-timezone'
React      = require 'react'
dateTime   = require 'common/util/dateTime'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{time}     = React.DOM
#--------------------------------------------------------------------------------

moment.locale(window.navigator.userLanguage ? window.navigator.language)

Time = React.createClass {

  displayName: 'Time'

  propTypes:
    time:     PropTypes.oneOfType [PropTypes.string, PropTypes.instanceOf(Date)]
    timezone: PropTypes.string
    format:   PropTypes.string
    relative: PropTypes.bool

  getDefaultProps: ->
    {relative: false}

  render: ->

    value = moment(@props.time)

    if @props.timezone?
      value = value.tz(@props.timezone)

    if @props.relative
      text = value.fromNow()
    else if @props.format?
      text = dateTime.format(value, @props.format)
    else
      text = value.calendar()

    props = mergeProps @props, {
      dateTime: value.toISOString()
      title:    value.format('dddd, MMMM Do YYYY, h:mm:ss a')
    }

    time props, text

}

module.exports = Time
