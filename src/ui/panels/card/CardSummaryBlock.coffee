React                    = require 'react'
PropTypes                = require 'framework/PropTypes'
Observe                  = require 'framework/mixins/Observe'
ChangeCardSummaryRequest = require 'requests/ChangeCardSummaryRequest'
Block                    = React.createFactory(require 'ui/common/Block')
EditableTextArea         = React.createFactory(require 'ui/common/EditableTextArea')

CardSummaryBlock = React.createClass {

  displayName: 'CardSummaryBlock'

  propTypes:
    card: PropTypes.Card.isRequired

  mixins: [Observe()]

  render: ->

    Block {className: 'summary', title: 'Summary', collapsible: true},
      EditableTextArea {
        className:   'editable'
        placeholder: 'Card Summary'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }

  onSummaryChanged: (value) ->
    @execute new ChangeCardSummaryRequest(@props.card, value)

}

module.exports = CardSummaryBlock
