_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'framework/PropTypes'
{li, span} = React.DOM

CardSummaryChangedNote = React.createClass {

  displayName: 'CardSummaryChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    if @props.note.content.from?
      children = @renderChange()
    else
      children = @renderSet()
    li {className: 'note activity summary-changed'}, children

  renderSet: -> [
    "Set the card's summary to "
    span {className: 'value'}, [@props.note.content.to]
  ]

  renderChange: -> [
    "Changed the card's summary from "
    span {className: 'value'}, [@props.note.content.from]
    " to "
    span {className: 'value'}, [@props.note.content.to]
  ]

}

module.exports = CardSummaryChangedNote
