#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
CardLocation = React.createFactory(require 'ui/common/CardLocation')
CardDueDate  = React.createFactory(require 'ui/screens/workspace/panels/card/CardDueDate')
CardGoals    = React.createFactory(require 'ui/screens/workspace/panels/card/CardGoals')
{div}        = React.DOM
#--------------------------------------------------------------------------------
require './CardWidgets.styl'
#--------------------------------------------------------------------------------

CardWidgets = React.createClass {

  displayName: 'CardWidgets'

  propTypes:
    card:    PropTypes.Card
    stack:   PropTypes.Stack
    panelid: PropTypes.string

  mixins: [CachedState]

  getCachedState: (cache) ->
    {goals: cache('goalsByCard').get(@props.card.id)}

  render: ->

    goals = CardGoals   {card: @props.card, goals: @state.goals}
    due   = CardDueDate {card: @props.card}

    if @state.goals?.length == 0 and @props.card.due?
      optional = [due, goals]
    else
      optional = [goals, due]

    div {className: 'card-widgets'},
      CardLocation {className: 'card-widget', card: @props.card, stack: @props.stack, link: true}
      optional

}

module.exports = CardWidgets
