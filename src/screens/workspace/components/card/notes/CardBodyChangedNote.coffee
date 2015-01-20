_         = require 'lodash'
React     = require 'react'
PropTypes = require 'common/PropTypes'
{div}     = React.DOM

CardBodyChangedNote = React.createClass {

  displayName: 'CardBodyChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    div {}, [
      "Card body changed from #{@props.note.content.from} to #{@props.note.content.to} by #{@props.user.name}"
    ]

}

module.exports = CardBodyChangedNote
