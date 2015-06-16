_           = require 'lodash'
React       = require 'react/addons'
CardStatus  = require 'data/enums/CardStatus'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Avatar      = React.createFactory(require 'ui/common/Avatar')
Icon        = React.createFactory(require 'ui/common/Icon')
{span}      = React.DOM

CardOwner = React.createClass {

  displayName: 'CardOwner'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.card.user) if @props.card?.user?
    team: cache('teams').get(@props.card.team) if @props.card?.team?
  }

  render: ->

    if @props.card?.status == CardStatus.Complete
      Icon {className: 'card-owner', name: 'complete'}
    else if @state.user?
      Avatar {className: 'card-owner', user: @state.user}
    else if @state.team?
      Icon {className: 'card-owner', name: 'team'}
    else
      span {}

}

module.exports = CardOwner
