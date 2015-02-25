React                  = require 'react'
UserCompletedCardEvent = require 'events/ui/UserCompletedCardEvent'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
CommandContext         = require 'ui/framework/mixins/CommandContext'
Button                 = React.createFactory(require 'ui/common/Button')
{div}                  = React.DOM

CompleteCommandPanel = React.createClass {

  displayName: 'CompleteCommandPanel'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  render: ->

    div {className: 'complete command'},
      div {className: 'confirm'},
        'Are you sure you want to complete this card?'
      div {className: 'buttons'},
        Button {text: 'Complete Card', className: 'default', onClick: @onOkButtonClicked}
        Button {text: 'Cancel', onClick: @hideCommand}

  onOkButtonClicked: ->
    @publish new UserCompletedCardEvent(@props.card.id)
    @hideCommand()

}

module.exports = CompleteCommandPanel
