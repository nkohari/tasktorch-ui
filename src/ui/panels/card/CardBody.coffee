React                 = require 'react'
PropTypes             = require 'framework/PropTypes'
Observe               = require 'framework/mixins/Observe'
CardSummaryBlock      = React.createFactory(require 'ui/panels/card/CardSummaryBlock')
CardActionsBlock      = React.createFactory(require 'ui/panels/card/CardActionsBlock')
CardConversationBlock = React.createFactory(require 'ui/panels/card/CardConversationBlock')
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
