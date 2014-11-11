_                = require 'lodash'
React            = require 'react'
Flux             = require 'mixins/Flux'
CardGoal         = React.createFactory(require './CardGoal')
CardLocation     = React.createFactory(require './CardLocation')
CardParticipants = React.createFactory(require './CardParticipants')
{div}            = React.DOM

CardSubheader = React.createClass {

  displayName: 'CardSubheader'

  mixins: [Flux()]

  render: ->

    children = _.compact [
      CardLocation {key: 'location', stackId: @props.stack.id}
      CardGoal {key: 'goal', goal: @props.goal} if @props.goal?
      CardParticipants {key: 'participants', card: @props.card, participants: @props.participants, currentUser: @props.currentUser}
    ]

    div {className: 'subheader'}, children

}

module.exports = CardSubheader
