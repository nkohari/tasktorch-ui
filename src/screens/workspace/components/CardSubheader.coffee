_                = require 'lodash'
React            = require 'react'
Observe          = require 'mixins/Observe'
CardGoal         = React.createFactory(require './CardGoal')
CardLocation     = React.createFactory(require './CardLocation')
CardParticipants = React.createFactory(require './CardParticipants')
{div}            = React.DOM

CardSubheader = React.createClass {

  displayName: 'CardSubheader'

  mixins: [Observe()]

  render: ->

    children = _.compact [
      CardLocation {key: 'location', stackId: @props.stack.id}
      CardGoal {key: 'goal', goalId: @props.card.goal.id} if @props.card.goal?
      CardParticipants {key: 'participants', card: @props.card}
    ]

    div {className: 'subheader'}, children

}

module.exports = CardSubheader
