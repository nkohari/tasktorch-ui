React              = require 'react'
PropTypes          = require 'common/PropTypes'
Observe            = require 'mixins/Observe'
Constants          = require 'framework/Constants'
SetCardBodyRequest = require 'requests/SetCardBodyRequest'
MultilineText      = React.createFactory(require 'common/MultilineText')
{div}              = React.DOM

CardBody = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardBody'

  propTypes:
    card: PropTypes.Card.isRequired

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'body'}, [
      MultilineText {
        key:         'text'
        className:   'editable'
        placeholder: Constants.cardBody
        value:       @props.card.body
        save:        @setCardBody
      }
    ]

  # Events ------------------------------------------------------------------------

  setCardBody: (value) ->
    request = new SetCardBodyRequest(@props.card, value)
    request.execute()

  #--------------------------------------------------------------------------------
}

module.exports = CardBody
