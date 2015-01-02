React             = require 'react'
Observe           = require 'mixins/Observe'
DeleteCardRequest = require 'requests/DeleteCardRequest'
CardContext       = require '../CardContext'
Button            = React.createFactory(require 'common/Button')
{div}             = React.DOM

DeleteCommandPanel = React.createClass {

  displayName: 'DeleteCommandPanel'

  mixins: [CardContext, Observe()]

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'delete command'}, [
      div {className: 'confirm'}, [
        'Are you sure you want to send this card to the trash?'
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     icon: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}
      ]
    ]

  onOkButtonClicked: ->
    @execute new DeleteCardRequest(@props.card)
    @context.hideCommandPanel()

}

module.exports = DeleteCommandPanel
