React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CardLocation     = React.createFactory(require 'ui/common/CardLocation')
CardFollowers    = React.createFactory(require 'ui/screens/workspace/panels/card/CardFollowers')
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
      CardLocation  {className: 'card-widget', card: @props.card, stack: @props.stack, link: true}
      CardFollowers {className: 'card-widget', card: @props.card}
      GoalName      {className: 'card-widget', goalid: @props.card.goal} if @props.card.goal?
      div {className: 'right'},
        CardFollowToggle {card: @props.card}

}

module.exports = CardWidgets
