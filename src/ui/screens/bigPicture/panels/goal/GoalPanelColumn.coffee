#--------------------------------------------------------------------------------
_                      = require 'lodash'
React                  = require 'react'
CardStatus             = require 'data/enums/CardStatus'
PropTypes              = require 'ui/framework/PropTypes'
CachedState            = require 'ui/framework/mixins/CachedState'
KindPanelState         = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
Icon                   = React.createFactory(require 'ui/common/Icon')
BigPictureColumn       = React.createFactory(require 'ui/screens/bigPicture/BigPictureColumn')
GoalPanelColumnSection = React.createFactory(require 'ui/screens/bigPicture/panels/goal/GoalPanelColumnSection')
{div, ul}              = React.DOM
#--------------------------------------------------------------------------------

GoalPanelColumn = React.createClass {

  displayName: 'GoalPanelColumn'

  propTypes:
    kind:  PropTypes.Kind
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    count = @props.cards.length or 0
    plural = if count == 1 then '' else 's'

    cardsByStatus = _.extend {
      Warning:    []
      InProgress: []
      Idle:       []
      NotStarted: []
      Complete:   []
    }, _.groupBy(@props.cards, 'status')

    sections = _.map cardsByStatus, (cards, status) =>
      return unless cards.length > 0
      GoalPanelColumnSection {key: status, status, cards}

    BigPictureColumn {},
      div {className: 'header'},
        div {className: 'content'},
          div {className: 'name', onClick: @toggleKind},
            Icon {name: 'card', color: @props.kind.color}
            @props.kind.name
          div {className: 'count'}, "#{count} card#{plural}"
      div {className: 'content'},
        sections

  toggleKind: ->
    @getScreen('bigpicture').togglePanel(new KindPanelState(@props.kind.id))

}

module.exports = GoalPanelColumn
