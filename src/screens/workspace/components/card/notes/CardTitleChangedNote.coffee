_         = require 'lodash'
React     = require 'react'
PropTypes = require 'common/PropTypes'
{div}     = React.DOM

CardTitleChangedNote = React.createClass {

  displayName: 'CardTitleChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    div {}, [
      "Card title changed from #{@props.note.content.from} to #{@props.note.content.to} by #{@props.user.name}"
    ]

}

module.exports = CardTitleChangedNote
