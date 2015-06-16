_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Avatar      = React.createFactory(require 'ui/common/Avatar')
Time        = React.createFactory(require 'ui/common/Time')
{div, span} = React.DOM

CommentNote = React.createClass {

  displayName: 'CommentNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'comment'},
      Avatar {className: 'comment-user', user: @props.user}
      div {className: 'comment-body'},
        div {className: 'comment-header'},
          span {className: 'user'}, @props.user.name
          ' commented '
          Time {relative: true, time: @props.note.created}
        div {className: 'comment-content'},
          @props.note.content 

}

module.exports = CommentNote
