_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'common/PropTypes'
{li, span} = React.DOM

CardCreatedNote = React.createClass {

  displayName: 'CardCreatedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    li {className: 'note-body activity card-created'}, [
      'Created the card'
    ]

}

module.exports = CardCreatedNote
