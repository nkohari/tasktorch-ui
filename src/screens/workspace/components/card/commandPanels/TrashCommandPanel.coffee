React                  = require 'react'
Observe                = require 'mixins/Observe'
MoveCardToTrashRequest = require 'requests/MoveCardToTrashRequest'
CardCommandContext     = require '../CardCommandContext'
Button                 = React.createFactory(require 'common/Button')
{div}                  = React.DOM

TrashCommandPanel = React.createClass {

  displayName: 'TrashCommandPanel'

  mixins: [CardCommandContext, Observe()]

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'trash command'}, [
      div {className: 'confirm'}, [
        'Are you sure you want to send this card to the trash?'
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     icon: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommand}
      ]
    ]

  onOkButtonClicked: ->
    @execute new MoveCardToTrashRequest(@props.card)
    @context.hideCommand()

}

module.exports = TrashCommandPanel
