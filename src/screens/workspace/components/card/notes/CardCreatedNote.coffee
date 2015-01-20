_         = require 'lodash'
React     = require 'react'
PropTypes = require 'common/PropTypes'
{div}     = React.DOM

CardCreatedNote = React.createClass {

  displayName: 'CardCreatedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    div {}, [
      "Card created by #{@props.user.name}"
    ]

}

module.exports = CardCreatedNote
