React            = require 'react'
PropTypes        = require 'framework/PropTypes'
Observe          = require 'framework/mixins/Observe'
Frame            = React.createFactory(require 'ui/common/Frame')
TabBlock         = React.createFactory(require 'ui/common/TabBlock')
CardSummaryBlock = React.createFactory(require 'ui/panels/card/CardSummaryBlock')
CardActions      = React.createFactory(require 'ui/panels/card/CardActions')
CardConversation = React.createFactory(require 'ui/panels/card/CardConversation')

CardBody = React.createClass {

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  render: ->

    Frame {className: 'body'},
      CardSummaryBlock {card: @props.card}
      TabBlock {className: 'details', selected: 'actions'},
        CardActions      {key: 'actions',      title: 'Actions',      card: @props.card, kind: @props.kind}
        CardConversation {key: 'conversation', title: 'Conversation', card: @props.card}

}

module.exports = CardBody
