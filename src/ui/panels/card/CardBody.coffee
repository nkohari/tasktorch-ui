React                 = require 'react'
PropTypes             = require 'framework/PropTypes'
Observe               = require 'framework/mixins/Observe'
Frame                 = React.createFactory(require 'ui/common/Frame')
CardSummaryBlock      = React.createFactory(require 'ui/panels/card/CardSummaryBlock')
CardActionsBlock      = React.createFactory(require 'ui/panels/card/CardActionsBlock')
CardConversationBlock = React.createFactory(require 'ui/panels/card/CardConversationBlock')

CardBody = React.createClass {

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  render: ->

    Frame {className: 'body'},
      CardSummaryBlock      {card: @props.card}
      CardActionsBlock      {card: @props.card, kind: @props.kind}
      CardConversationBlock {card: @props.card}

}

module.exports = CardBody
