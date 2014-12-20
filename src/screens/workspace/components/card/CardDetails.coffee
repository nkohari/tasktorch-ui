React       = require 'react'
PropTypes   = require 'common/PropTypes'
Observe     = require 'mixins/Observe'
CardBody    = React.createFactory(require './CardBody')
CardActions = React.createFactory(require './CardActions')
{div}       = React.DOM

CardDetails = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardDetails'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'details'}, [
      CardBody    {key: 'body',    card: @props.card}
      CardActions {key: 'actions', card: @props.card, kind: @props.kind}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardDetails
