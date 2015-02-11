_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'framework/PropTypes'
{li, span} = React.DOM

CardTitleChangedNote = React.createClass {

  displayName: 'CardTitleChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    if @props.note.content.from?
      children = @renderChange()
    else
      children = @renderSet()
    li {className: 'note activity title-changed'}, children

  renderSet: -> [
    "Set the card's title to "
    span {className: 'value'}, [@props.note.content.to]
  ]

  renderChange: -> [
    "Changed the card's title from "
    span {className: 'value'}, [@props.note.content.from]
    " to "
    span {className: 'value'}, [@props.note.content.to]
  ]

}

module.exports = CardTitleChangedNote
