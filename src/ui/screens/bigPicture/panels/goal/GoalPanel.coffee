_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
ShellContext       = require 'ui/framework/mixins/ShellContext'
Icon               = React.createFactory(require 'ui/common/Icon')
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
GoalPanelColumn    = React.createFactory(require 'ui/screens/bigPicture/panels/goal/GoalPanelColumn')
GoalProgressBar    = React.createFactory(require 'ui/screens/bigPicture/panels/goal/GoalProgressBar')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

GoalPanel = React.createClass {

  displayName: 'GoalPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState, ShellContext]

  getCachedState: (cache) ->
    org   = @getCurrentOrg()
    goal  = cache('goals').get(@props.id)
    cards = cache('cardsByGoal').get(@props.id)
    kinds = cache('kindsByOrg').get(org.id)
    {goal, cards, kinds}

  render: ->

    if @state.kinds? and @state.cards?
      cardsByKind = _.groupBy(@state.cards, 'kind')
      columns = _.map @state.kinds, (kind) =>
        return unless cardsByKind[kind.id]?.length > 0
        GoalPanelColumn {key: kind.id, kind, cards: cardsByKind[kind.id]}

    div {className: 'big-picture panel'},
      PanelHeader {panelid: @props.id, icon: 'goal'},
        @state.goal?.name
      div {className: 'subheader'},
        GoalProgressBar {goal: @state.goal, cards: @state.cards}
      div {className: 'content'},
        columns
      div {className: 'footer'}

}

module.exports = GoalPanel
