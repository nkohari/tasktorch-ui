#--------------------------------------------------------------------------------
_           = require 'lodash'
moment      = require 'moment'
React       = require 'react'
{DateUtils} = require 'react-day-picker'
DayPicker   = React.createFactory(require 'react-day-picker')
Button      = React.createFactory(require 'ui/common/Button')
Input       = React.createFactory(require 'ui/common/Input')
{PropTypes} = React
{div}       = React.DOM
#--------------------------------------------------------------------------------
require './DateRangePicker.styl'
#--------------------------------------------------------------------------------

DateRangePicker = React.createClass {

  displayName: 'DateRangePicker'

  propTypes:
    from:     PropTypes.instanceOf(Date)
    to:       PropTypes.instanceOf(Date)
    format:   PropTypes.string
    onChange: PropTypes.func

  getDefaultProps: -> {
    from:   new Date()
    to:     moment().add(1, 'months').toDate()
    format: "l"
  }

  getInitialState: -> {
    from:     @props.from
    to:       @props.to
    fromText: moment(@props.from).format(@props.format)
    toText:   moment(@props.to).format(@props.format)
  }

  render: ->

    div {className: 'date-range-picker'},
      div {className: 'top'},
        Input {ref: 'from', placeholder: 'Start date', value: @state.fromText, onChange: @onFromChanged}
        "\u2014"
        Input {ref: 'to',   placeholder: 'End date',   value: @state.toText,   onChange: @onToChanged}
      DayPicker {
        ref: 'picker'
        numberOfMonths: 3
        enableOutsideDays: true
        modifiers:
          selected: (day) => DateUtils.isDayInRange(day, @state)
        @onDayClick
      }

  focus: ->
    @refs.from.focus()

  onFromChanged: (event) ->
    text = event.target.value
    date = moment(text, @props.format, true)
    if date.isValid()
      @setState {from: date.toDate(), fromText: text}, @sync
    else
      @setState {fromText: text}

  onToChanged: (event) ->
    text = event.target.value
    date = moment(text, @props.format, true)
    if date.isValid()
      @setState {to: date.toDate(), toText: text}, @sync
    else
      @setState {toText: text}

  onDayClick: (event, date) ->
    range = DateUtils.addDayToRange(date, @state)
    @setState({
      from:     range.from
      to:       range.to
      fromText: moment(range.from).format(@props.format)
      toText:   moment(range.to).format(@props.format)
    }, @sync)

  sync: ->
    @props.onChange {from: @state.from, to: @state.to} if @props.onChange?

}

module.exports = DateRangePicker
