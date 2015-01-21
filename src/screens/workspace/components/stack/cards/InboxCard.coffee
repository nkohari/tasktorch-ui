_                  = require 'lodash'
moment             = require 'moment'
React              = require 'react'
PropTypes          = require 'common/PropTypes'
UserDisplayedEvent = require 'events/display/UserDisplayedEvent'
MoveType           = require 'framework/enums/MoveType'
Observe            = require 'mixins/Observe'
Avatar             = React.createFactory(require 'common/Avatar')
Time               = React.createFactory(require 'common/Time')
{div, span}        = React.DOM

InboxCard = React.createClass {

  displayName: 'InboxCard'

  propTypes:
    card: PropTypes.Card

  mixins: [Observe('users')]

  sync: (stores) ->
    pass = @getLastPass(@props.card)
    {sender: stores.users.get(pass.user)}

  ready: ->
    {sender: @state.sender?}

  componentWillMount: ->
    pass = @getLastPass(@props.card)
    @publish new UserDisplayedEvent(pass.user)

  componentWillReceiveProps: (newProps) ->
    prev = @getLastPass(@props.card)
    curr = @getLastPass(newProps.card)
    @publish new UserDisplayedEvent(curr.user) if prev.user != curr.user

  render: ->
    div {
      className: 'summary'
      style: {borderLeftColor: @props.kind.color}
    }, @contents()

  children: ->
    pass = @getLastPass(@props.card)
    return [
      Avatar {key: 'avatar', user: @state.sender}
      div {className: 'title'}, [@props.card.title or 'Untitled Card']
      div {className: 'subtitle'}, [
        Time {key: 'time', time: pass.time}
      ]
    ]

  getLastPass: (card) ->
    passes = _.filter card.moves, (move) -> move.type == MoveType.Pass
    return _.max passes, (pass) -> moment(pass.time).valueOf()

}

module.exports = InboxCard
