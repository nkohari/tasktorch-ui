#--------------------------------------------------------------------------------
_              = require 'lodash'
moment         = require 'moment'
React          = require 'react'
{DateUtils}    = require 'react-day-picker'
DayPicker      = React.createFactory(require 'react-day-picker')
Button         = React.createFactory(require 'ui/common/Button')
Input          = React.createFactory(require 'ui/common/Input')
{PropTypes}    = React
{div}          = React.DOM
#--------------------------------------------------------------------------------
require './DatePicker.styl'
#--------------------------------------------------------------------------------

DatePicker = React.createClass {

  displayName: 'DatePicker'

  propTypes:
    value:    PropTypes.oneOfType [PropTypes.string, PropTypes.instanceOf(Date)]
    month:    PropTypes.oneOfType [PropTypes.string, PropTypes.instanceOf(Date)]
    format:   PropTypes.string
    onChange: PropTypes.func

  getDefaultProps: -> {
    value:  new Date()
    format: "l"
  }

  getInitialState: -> {
    value: @props.value
    text:  moment(@props.value).format(@props.format)
  }

  render: ->

    div {className: 'date-picker'},
      div {className: 'top'},
        Input {
          ref: 'input'
          value: @state.text
          onChange: @onInputChange
        }
        Button {
          className: 'small'
          text: 'Today'
          onClick: @selectToday
        }
      DayPicker {
        ref: 'picker'
        initialMonth: @props.value ? new Date()
        enableOutsideDays: true
        modifiers:
          selected: (day) => @state.value? and DateUtils.isSameDay(@state.value, day)
        @onDayClick
      }

  focus: ->
    @refs.input.select()

  selectToday: ->
    @setValue(new Date())

  onInputChange: (event) ->
    text  = event.target.value
    value = moment(text, @props.format, true)
    if value.isValid()
      @setValue(value, text)
    else
      @setValue(null, text)

  onDayClick: (event, value) ->
    @setValue(value)

  setValue: (value, text) ->
    @setState({
      value: if value? then moment(value).toDate() else null
      text:  text ? moment(value).format(@props.format)
    }, @sync)

  sync: ->
    @refs.picker.showMonth(@state.value) if @state.value?
    @props.onChange(@state.value)        if @props.onChange?

}

module.exports = DatePicker
