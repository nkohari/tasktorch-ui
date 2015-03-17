_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
PanelKey     = require 'ui/framework/PanelKey'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
UrlAware     = require 'ui/framework/mixins/UrlAware'
CardLocation = React.createFactory(require 'ui/common/CardLocation')
CardOwner    = React.createFactory(require 'ui/common/CardOwner')
Link         = React.createFactory(require 'ui/common/Link')
Frame        = React.createFactory(require 'ui/common/Frame')
ListItem     = React.createFactory(require 'ui/common/ListItem')
StackName    = React.createFactory(require 'ui/common/StackName')
Time         = React.createFactory(require 'ui/common/Time')

FollowingCard = React.createClass {

  displayName: 'FollowingCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, UrlAware]

  getCachedState: (cache) -> {
    kind:  cache('kinds').get(@props.card.kind)
    user:  cache('users').get(@props.card.user)   if @props.card.user?
    team:  cache('teams').get(@props.card.team)   if @props.card.team?
    stack: cache('stacks').get(@props.card.stack) if @props.card.stack?
  }

  isReady: ->
    @state.kind? and (@state.user? or not @props.card.user?) and (@state.team? or not @props.card.team?) and (@state.stack? or not @props.card.stack?)

  render: ->

    if @state.kind?
      style = {borderLeftColor: @state.kind.color}

    classes = classSet [
      'active' if @getCurrentUrl().isPanelActive(PanelKey.forCard(@props.card.id))
    ]

    ListItem {@isReady, className: 'following-card'},
      Link {className: classes, style, @getLinkUrl},
        CardOwner {user: @state.user, team: @state.team}
        Frame {className: 'title'},
          @props.card.title or 'Untitled Card'
        Frame {className: 'widgets'},
          CardLocation {card: @props.card, stack: @state.stack}

  getLinkUrl: (currentUrl) ->
    currentUrl.addPanelAfter(PanelKey.forCard(@props.card.id), PanelKey.forFollowing())

}

module.exports = FollowingCard
