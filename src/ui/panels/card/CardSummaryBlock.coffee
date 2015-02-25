React                       = require 'react'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
Pure                        = require 'ui/framework/mixins/Pure'
UserChangedCardSummaryEvent = require 'events/ui/UserChangedCardSummaryEvent'
Block                       = React.createFactory(require 'ui/common/Block')
EditableTextArea            = React.createFactory(require 'ui/common/EditableTextArea')

CardSummaryBlock = React.createClass {

  displayName: 'CardSummaryBlock'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, Pure]

  render: ->

    Block {className: 'summary', title: 'Summary', collapsible: true},
      EditableTextArea {
        className:   'editable'
        placeholder: 'Card Summary'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }

  onSummaryChanged: (value) ->
    @publish new UserChangedCardSummaryEvent(@props.card.id, value)

}

module.exports = CardSummaryBlock
