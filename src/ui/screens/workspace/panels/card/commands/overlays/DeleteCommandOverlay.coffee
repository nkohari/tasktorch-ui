React                = require 'react'
UserDeletedCardEvent = require 'events/ui/UserDeletedCardEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CommandContext       = require 'ui/framework/mixins/CommandContext'
Button               = React.createFactory(require 'ui/common/Button')
Prompt               = React.createFactory(require 'ui/common/Prompt')
CardCommandOverlay   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}                = React.DOM

DeleteCommandOverlay = React.createClass {

  displayName: 'DeleteCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Delete Card', className: 'default', onClick: @onOkButtonClicked}
      Button {text: 'Cancel', onClick: @hideCommand}

    hint = """
      Deleting a card immediately and permanently removes it. If you've just finished
      work on the card, you should mark it as complete instead of deleting it.
    """

    CardCommandOverlay {className: 'complete', buttons},
      Prompt {hint},
        'Are you sure you want to delete this card?'

  onOkButtonClicked: ->
    @publish new UserDeletedCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = DeleteCommandOverlay
