React                 = require 'react'
UserAcceptedCardEvent = require 'events/ui/UserAcceptedCardEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CommandContext        = require 'ui/framework/mixins/CommandContext'
Button                = React.createFactory(require 'ui/common/Button')
Prompt                = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                 = React.DOM

AcceptCommandOverlay = React.createClass {

  displayName: 'AcceptCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Add to My Queue', className: 'default', onClick: @acceptCard.bind(this, false)}
      Button {text: 'Start Immediately', onClick: @acceptCard.bind(this, true)}
      Button {text: 'Cancel', onClick: @hideCommand}

    hint = """
      Accepting the card will move it to your queue, which lets everyone know that
      you intend to work on it. If you choose to begin working on it immediately,
      it will be placed at the top of your queue, otherwise, it will be added to the bottom.
    """

    CardCommandOverlay {className: 'complete', buttons},
      Prompt {hint},
        'Will you accept responsibility for this card?'

  acceptCard: (preempt) ->
    @publish new UserAcceptedCardEvent(@props.card.id, preempt)
    @hideCommand()

}

module.exports = AcceptCommandOverlay
