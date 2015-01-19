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

  mixins: [Observe()]

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
    @execute new SetCardBodyRequest(@props.card, value)

  #--------------------------------------------------------------------------------
}

module.exports = CardBody
