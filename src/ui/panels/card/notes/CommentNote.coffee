_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'framework/PropTypes'
{li, span} = React.DOM

CommentNote = React.createClass {

  displayName: 'CommentNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->
    li {className: 'note comment'}, [
      @props.note.content
    ]

}

module.exports = CommentNote
