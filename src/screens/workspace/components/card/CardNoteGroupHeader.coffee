_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'common/PropTypes'
Time        = React.createFactory(require 'common/Time')
Avatar      = React.createFactory(require 'common/Avatar')
{div, span} = React.DOM

CardNoteGroupHeader = React.createClass {

  displayName: 'CardNoteGroupHeader'

  propTypes:
    card:  PropTypes.Card
    user:  PropTypes.User
    notes: PropTypes.arrayOf(PropTypes.Note)

  render: ->
    div {className: 'header'}, [
      Avatar {key: 'avatar', user: @props.user}
      div {className: 'meta'}, [
        span {className: 'user'}, [@props.user.name]
        Time {time: _.first(@props.notes).time}
      ]
    ]

}

module.exports = CardNoteGroupHeader