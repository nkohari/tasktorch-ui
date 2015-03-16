React                = require 'react'
UserDeletedCardEvent = require 'events/ui/UserDeletedCardEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CommandContext       = require 'ui/framework/mixins/CommandContext'
Button               = React.createFactory(require 'ui/common/Button')
{div}                = React.DOM

DeleteCommandPanel = React.createClass {

  displayName: 'DeleteCommandPanel'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    div {className: 'delete command'},
      div {className: 'confirm'},
        'Are you sure you want to send this card to the trash?'
      div {className: 'buttons'},
        Button {text: 'Send to Trash', className: 'default warning', onClick: @onOkButtonClicked}
        Button {text: 'Cancel', onClick: @hideCommand}

  onOkButtonClicked: ->
    @publish new UserDeletedCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = DeleteCommandPanel
