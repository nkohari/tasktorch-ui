React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Frame            = React.createFactory(require 'ui/common/Frame')
TabBlock         = React.createFactory(require 'ui/common/TabBlock')
CardSummaryBlock = React.createFactory(require 'ui/screens/workspace/panels/card/CardSummaryBlock')
CardActions      = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardActions')
CardTimeline     = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/CardTimeline')

CardBody = React.createClass {

  displayName: 'CardBody'

  propTypes:
    card:        PropTypes.Card
    kind:        PropTypes.Kind
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'body'},
      CardSummaryBlock {card: @props.card}
      TabBlock {className: 'details', selected: 'actions'},
        CardActions  {key: 'actions',  title: 'Actions',  card: @props.card, kind: @props.kind}
        CardTimeline {key: 'timeline', title: 'Timeline', card: @props.card, currentUser: @props.currentUser}

}

module.exports = CardBody
