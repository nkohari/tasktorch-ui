_            = require 'lodash'
React        = require 'react'
Observe      = require 'mixins/Observe'
CardGoal     = React.createFactory(require './CardGoal')
CardLocation = React.createFactory(require './CardLocation')
{ul}         = React.DOM

CardWidgets = React.createClass {

  displayName: 'CardWidgets'

  mixins: [Observe()]

  render: ->
    ul {className: 'widgets'}, _.compact [
      CardLocation {key: 'location', stackId: @props.stack.id}
      CardGoal {key: 'goal', goalId: @props.card.goal.id} if @props.card.goal?
    ]

}

module.exports = CardWidgets
