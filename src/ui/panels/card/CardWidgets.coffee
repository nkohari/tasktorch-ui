_            = require 'lodash'
React        = require 'react'
Frame        = React.createFactory(require 'ui/common/Frame')
CardLocation = React.createFactory(require 'ui/common/CardLocation')
GoalName     = React.createFactory(require 'ui/common/GoalName')
{div}        = React.DOM

CardWidgets = React.createClass {

  displayName: 'CardWidgets'

  render: ->

    Frame {className: 'widgets'},
      CardLocation {card: @props.card, stack: @props.stack, link: true}
      GoalName     {goalid: @props.card.goal} if @props.card.goal?

}

module.exports = CardWidgets
