_            = require 'lodash'
React        = require 'react'
CardGoal     = React.createFactory(require 'ui/panels/card/CardGoal')
CardLocation = React.createFactory(require 'ui/panels/card/CardLocation')
{ul}         = React.DOM

CardWidgets = React.createClass {

  displayName: 'CardWidgets'

  render: ->

    ul {className: 'widgets'},
      CardLocation {card: @props.card, stack: @props.stack}
      CardGoal     {goalid: @props.card.goal} if @props.card.goal?

}

module.exports = CardWidgets
