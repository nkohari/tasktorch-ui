React                    = require 'react'
PropTypes                = require 'common/PropTypes'
Observe                  = require 'mixins/Observe'
ChangeCardSummaryRequest = require 'requests/ChangeCardSummaryRequest'
MultilineText            = React.createFactory(require 'common/MultilineText')
{div}                    = React.DOM

CardSummary = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardSummary'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe()]

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'summary'}, [
      MultilineText {
        key:         'text'
        className:   'editable'
        placeholder: 'Card Summary'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }
    ]

  # Events ------------------------------------------------------------------------

  onSummaryChanged: (value) ->
    @execute new ChangeCardSummaryRequest(@props.card, value)

  #--------------------------------------------------------------------------------
}

module.exports = CardSummary
