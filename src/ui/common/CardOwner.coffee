#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
CardStatus           = require 'data/enums/CardStatus'
UserOpenedPanelEvent = require 'events/ui/UserOpenedPanelEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
UserPanelSpec        = require 'ui/framework/panels/UserPanelSpec'
Avatar               = React.createFactory(require 'ui/common/Avatar')
Icon                 = React.createFactory(require 'ui/common/Icon')
{span}               = React.DOM
#--------------------------------------------------------------------------------
require './CardOwner.styl'
#--------------------------------------------------------------------------------

CardOwner = React.createClass {

  displayName: 'CardOwner'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    if @props.card?.user?
      user = cache('users').get(@props.card.user)
    else if @props.card?.team?
      team = cache('teams').get(@props.card.team)
    {team, user}

  render: ->

    if @props.card?.status == CardStatus.Complete
      Icon {className: 'card-owner', name: 'complete'}
    else if @state.user?
      Avatar {className: 'card-owner', user: @state.user, size: 54, presence: true, onClick: @openUserPanel}
    else if @state.team?
      Icon {className: 'card-owner', name: 'team'}
    else
      span {}

  openUserPanel: ->
    @publish new UserOpenedPanelEvent(new UserPanelSpec(@state.user.id), {after: @props.card.id})

}

module.exports = CardOwner
