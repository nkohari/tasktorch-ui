React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
TabBlock          = React.createFactory(require 'ui/common/TabBlock')
CardSummaryBlock  = React.createFactory(require 'ui/screens/workspace/panels/card/CardSummaryBlock')
CardActionsTab    = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActionsTab')
CardTimelineTab   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CardTimelineTab')
{div}             = React.DOM

CardBody = React.createClass {

  displayName: 'CardBody'

  propTypes:
    card:        PropTypes.Card
    kind:        PropTypes.Kind
    currentUser: PropTypes.User

  render: ->

    div {className: 'card-body'},
      CardSummaryBlock {card: @props.card}
      TabBlock {className: 'card-details', selected: 'actions'},
        CardActionsTab  {key: 'actions',  title: 'Actions',  card: @props.card, kind: @props.kind}
        CardTimelineTab {key: 'timeline', title: 'Timeline', card: @props.card, currentUser: @props.currentUser}

}

module.exports = CardBody
