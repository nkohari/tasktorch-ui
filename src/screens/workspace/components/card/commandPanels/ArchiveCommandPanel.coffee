React                    = require 'react'
Observe                  = require 'mixins/Observe'
MoveCardToArchiveRequest = require 'requests/MoveCardToArchiveRequest'
CardCommandContext       = require '../CardCommandContext'
Button                   = React.createFactory(require 'common/Button')
{div}                    = React.DOM

ArchiveCommandPanel = React.createClass {

  displayName: 'ArchiveCommandPanel'

  mixins: [CardCommandContext, Observe()]

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'archive command'}, [
      div {className: 'confirm'}, [
        'Are you sure you want to send this card to the archive?'
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     icon: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommand}
      ]
    ]

  onOkButtonClicked: ->
    @execute new MoveCardToArchiveRequest(@props.card)
    @context.hideCommand()

}

module.exports = ArchiveCommandPanel
