_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Avatar      = React.createFactory(require 'ui/common/Avatar')
Icon        = React.createFactory(require 'ui/common/Icon')
{div, span} = React.DOM

CardCreatedNote = React.createClass {

  displayName: 'CardCreatedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'activity'},
      Icon {name: 'create-card'}
      div {className: 'activity-body'},
        span {className: 'activity-user'},
          Avatar {user: @props.user}
          @props.user.name
        'created the card'

}

module.exports = CardCreatedNote
