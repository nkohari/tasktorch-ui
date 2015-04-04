_                = require 'lodash'
React            = require 'react/addons'
classSet         = require 'common/util/classSet'
CardCommand      = require 'data/enums/CardCommand'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
Avatar           = React.createFactory(require 'ui/common/Avatar')
Frame            = React.createFactory(require 'ui/common/Frame')
CardFollowToggle = React.createFactory(require 'ui/common/CardFollowToggle')
CardOwner        = React.createFactory(require 'ui/common/CardOwner')
CardTitle        = React.createFactory(require 'ui/screens/workspace/panels/card/CardTitle')
CardWidgets      = React.createFactory(require 'ui/screens/workspace/panels/card/CardWidgets')
{div}            = React.DOM

CardHeader = React.createClass {

  displayName: 'CardHeader'

  propTypes:
    card:        PropTypes.Card
    kind:        PropTypes.Kind
    stack:       PropTypes.Stack
    panelid:     PropTypes.string
    currentUser: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.card.user) if @props.card.user?
    team: cache('teams').get(@props.card.team) if @props.card.team?
  }

  isReady: ->
    (@state.user? or not @props.card.user?) and (@state.team? or not @props.card.team?)

  render: ->

    classes = classSet [
      'card-header'
      @props.kind.color
      'expanded' if @state.activeCommand?
    ]

    Frame {@isReady, className: classes},
      CardOwner {user: @state.user, team: @state.team}
      div {className: 'card-info'},
        CardTitle   {card: @props.card}
        CardWidgets {card: @props.card, kind: @props.kind, stack: @props.stack}
      div {className: 'controls'},
        CardFollowToggle {card: @props.card, currentUser: @props.currentUser}
}

module.exports = CardHeader
