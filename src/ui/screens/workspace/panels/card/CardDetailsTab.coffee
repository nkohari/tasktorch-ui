React                       = require 'react'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
Pure                        = require 'ui/framework/mixins/Pure'
UserChangedCardSummaryEvent = require 'events/ui/UserChangedCardSummaryEvent'
EditableTextArea            = React.createFactory(require 'ui/common/EditableTextArea')
{div}                       = React.DOM

CardDetailsTab = React.createClass {

  displayName: 'CardDetailsTab'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, Pure]

  render: ->

    div {className: 'card-details-tab'},
      EditableTextArea {
        className:   'editable'
        rows:        1
        placeholder: 'Describe the problem to be solved, or the idea to be implemented.'
        value:       @props.card.summary
        save:        @onSummaryChanged
      }

  onSummaryChanged: (value) ->
    @publish new UserChangedCardSummaryEvent(@props.card.id, value)

}

module.exports = CardDetailsTab
