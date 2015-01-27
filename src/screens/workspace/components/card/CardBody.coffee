React                 = require 'react'
PropTypes             = require 'common/PropTypes'
Observe               = require 'mixins/Observe'
CardSummaryBlock      = React.createFactory(require './CardSummaryBlock')
CardActionsBlock      = React.createFactory(require './CardActionsBlock')
CardConversationBlock = React.createFactory(require './CardConversationBlock')
{div}                 = React.DOM

CardBody = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'body'}, [
      CardSummaryBlock      {key: 'summary', card: @props.card}
      CardActionsBlock      {key: 'actions', card: @props.card, kind: @props.kind}
      CardConversationBlock {key: 'notes',   card: @props.card}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardBody
