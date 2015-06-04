React                 = require 'react'
UserRestoredCardEvent = require 'events/ui/UserRestoredCardEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CommandContext        = require 'ui/framework/mixins/CommandContext'
Button                = React.createFactory(require 'ui/common/Button')
Prompt                = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                 = React.DOM

RestoreCommandOverlay = React.createClass {

  displayName: 'RestoreCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Restore Card', className: 'default', onClick: @restoreCard}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'restore', buttons},
      Prompt {hint: 'restore-card'},
        'Are you sure you want to restore this card?'

  restoreCard: ->
    @publish new UserRestoredCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = RestoreCommandOverlay
