_                    = require 'lodash'
React                = require 'react/addons'
classSet             = require 'common/util/classSet'
CardCommand          = require 'data/enums/CardCommand'
PropTypes            = require 'ui/framework/PropTypes'
CachedState          = require 'ui/framework/mixins/CachedState'
CommandContextMaster = require 'ui/framework/mixins/CommandContextMaster'
Avatar               = React.createFactory(require 'ui/common/Avatar')
Frame                = React.createFactory(require 'ui/common/Frame')
Icon                 = React.createFactory(require 'ui/common/Icon')
CardOwner            = React.createFactory(require 'ui/common/CardOwner')
CardCommandBar       = React.createFactory(require 'ui/panels/card/CardCommandBar')
CardCommandPanel     = React.createFactory(require 'ui/panels/card/CardCommandPanel')
CardTitle            = React.createFactory(require 'ui/panels/card/CardTitle')
CardWidgets          = React.createFactory(require 'ui/panels/card/CardWidgets')
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
{div}                = React.DOM

CardHeader = React.createClass {

  displayName: 'CardHeader'

  propTypes:
    card:        PropTypes.Card
    kind:        PropTypes.Kind
    currentUser: PropTypes.User

  mixins: [CachedState, CommandContextMaster]

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.card.stack) if @props.card.stack?
    user:  cache('users').get(@props.card.user)   if @props.card.user?
    team:  cache('teams').get(@props.card.team)   if @props.card.team?
  }

  isReady: ->
    (@state.stack? or not @props.card.stack?) and (@state.user? or not @props.card.user?) and (@state.team? or not @props.card.team?)

  render: ->

    classes = classSet [
      'header'
      'expanded' if @state.activeCommand?
    ]

    style = {borderColor: @props.kind.color}

    Frame {@isReady, className: classes, style},
      div {className: 'fixed'},
        CardOwner {user: @state.user, team: @state.team}
        div {className: 'info'},
          CardTitle   {card: @props.card}
          CardWidgets {card: @props.card, stack: @state.stack}
        CardCommandBar {card: @props.card, stack: @state.stack}
      CSSTransitionGroup {className: 'flexible', component: 'div', transitionName: 'slide'},
        CardCommandPanel {card: @props.card, stack: @state.stack} if @hasActiveCommand()

}

module.exports = CardHeader
