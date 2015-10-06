#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Time       = React.createFactory(require 'ui/common/Time')
#--------------------------------------------------------------------------------

UPDATE_FREQUENCY_MS = 500

Clock = React.createClass {

  displayName: 'Clock'

  getInitialState: ->
    {time: new Date()}

  componentDidMount: ->
    @timeout = setTimeout(@updateTime, UPDATE_FREQUENCY_MS)

  componentWillUnmount: ->
    clearTimeout(@timeout) if @timeout?

  render: ->

    props = mergeProps @props, {
      time: @state.time
      className: 'clock'
    }

    Time props

  updateTime: ->
    @setState {time: new Date()}
    @timeout = setTimeout(@updateTime, UPDATE_FREQUENCY_MS)

}

module.exports = Clock
