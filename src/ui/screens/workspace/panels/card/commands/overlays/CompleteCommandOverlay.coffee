React                  = require 'react'
UserCompletedCardEvent = require 'events/ui/UserCompletedCardEvent'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
CommandContext         = require 'ui/framework/mixins/CommandContext'
Button                 = React.createFactory(require 'ui/common/Button')
CardCommandOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                  = React.DOM

CompleteCommandOverlay = React.createClass {

  displayName: 'CompleteCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Complete Card', className: 'default', onClick: @onOkButtonClicked}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'complete', buttons},
      div {className: 'prompt'},
        'Are you sure you want to complete this card?'
      div {className: 'hint'},
        "By marking this card as complete, you're telling everyone that no more work "
        "needs to be done on the card. Complete cards are sent to the archive."

  onOkButtonClicked: ->
    @publish new UserCompletedCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = CompleteCommandOverlay
