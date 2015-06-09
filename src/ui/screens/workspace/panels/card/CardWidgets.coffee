React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CardLocation     = React.createFactory(require 'ui/common/CardLocation')
CardGoals        = React.createFactory(require 'ui/screens/workspace/panels/card/CardGoals')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
GoalName         = React.createFactory(require 'ui/common/GoalName')
{div}            = React.DOM

CardWidgets = React.createClass {

  displayName: 'CardWidgets'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stack: PropTypes.Stack

  render: ->

    div {className: 'card-widgets'},
      CardLocation {className: 'card-widget', card: @props.card, stack: @props.stack, link: true}
      CardGoals    {className: 'card-widget', card: @props.card}
      div {className: 'right'},
        CardFollowToggle {card: @props.card}

}

module.exports = CardWidgets
