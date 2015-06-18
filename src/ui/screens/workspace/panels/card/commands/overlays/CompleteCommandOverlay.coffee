#--------------------------------------------------------------------------------
React                  = require 'react'
UserCompletedCardEvent = require 'events/ui/UserCompletedCardEvent'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
CommandContext         = require 'ui/framework/mixins/CommandContext'
Button                 = React.createFactory(require 'ui/common/Button')
Prompt                 = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                  = React.DOM
#--------------------------------------------------------------------------------

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
      Prompt {hint: 'complete-card'},
        'Are you sure you want to complete this card?'

  onOkButtonClicked: ->
    @publish new UserCompletedCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = CompleteCommandOverlay
