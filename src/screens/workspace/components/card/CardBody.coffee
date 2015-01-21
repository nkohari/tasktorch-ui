React            = require 'react'
PropTypes        = require 'common/PropTypes'
Observe          = require 'mixins/Observe'
CardSummary      = React.createFactory(require './CardSummary')
CardActionsBlock = React.createFactory(require './CardActionsBlock')
CardNotesBlock   = React.createFactory(require './CardNotesBlock')
{div}            = React.DOM

CardBody = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'body'}, [
      CardSummary      {key: 'summary', card: @props.card}
      CardActionsBlock {key: 'actions', card: @props.card, kind: @props.kind}
      CardNotesBlock   {key: 'notes',   card: @props.card}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardBody
