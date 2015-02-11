_            = require 'lodash'
React        = require 'react'
CardGoal     = React.createFactory(require 'ui/panels/card/CardGoal')
CardLocation = React.createFactory(require 'ui/panels/card/CardLocation')
{ul}         = React.DOM

CardWidgets = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardWidgets'

  # Rendering ---------------------------------------------------------------------

  render: ->
    ul {className: 'widgets'}, [
      CardLocation {key: 'location', card: @props.card, stack: @props.stack}
      CardGoal     {key: 'goal', goalid: @props.card.goal} if @props.card.goal?
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardWidgets
