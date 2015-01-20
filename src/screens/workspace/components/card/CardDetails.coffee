React         = require 'react'
PropTypes     = require 'common/PropTypes'
Observe       = require 'mixins/Observe'
CardBody      = React.createFactory(require './CardBody')
CardStageList = React.createFactory(require './CardStageList')
CardNoteList  = React.createFactory(require './CardNoteList')
{div}         = React.DOM

CardDetails = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardDetails'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'details'}, [
      CardBody      {key: 'body',   card: @props.card}
      CardStageList {key: 'stages', card: @props.card, kind: @props.kind}
      CardNoteList  {key: 'notes',  card: @props.card}
    ]

  #--------------------------------------------------------------------------------

}

module.exports = CardDetails
