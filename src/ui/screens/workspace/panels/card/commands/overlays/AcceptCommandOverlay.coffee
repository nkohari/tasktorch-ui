#--------------------------------------------------------------------------------
React                 = require 'react'
UserAcceptedCardEvent = require 'events/ui/UserAcceptedCardEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CommandContext        = require 'ui/framework/mixins/CommandContext'
Button                = React.createFactory(require 'ui/common/Button')
Prompt                = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                 = React.DOM
#--------------------------------------------------------------------------------

AcceptCommandOverlay = React.createClass {

  displayName: 'AcceptCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Add to My Priorities', className: 'default', onClick: @acceptCard.bind(this, false)}
      Button {text: 'Make Top Priority', onClick: @acceptCard.bind(this, true)}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'complete', buttons},
      Prompt {hint: 'accept-card'},
        'Will you accept responsibility for this card?'

  acceptCard: (preempt) ->
    @publish new UserAcceptedCardEvent(@props.card.id, preempt)
    @hideCommand()

}

module.exports = AcceptCommandOverlay
