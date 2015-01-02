React               = require 'react'
Observe             = require 'mixins/Observe'
CompleteCardRequest = require 'requests/CompleteCardRequest'
CardContext         = require '../CardContext'
Button              = React.createFactory(require 'common/Button')
{div}               = React.DOM

CompleteCommandPanel = React.createClass {

  displayName: 'CompleteCommandPanel'

  mixins: [CardContext, Observe()]

  render: ->

    div {className: 'complete command'}, [
      div {className: 'confirm'}, [
        'Are you sure you want to complete this card?'
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     icon: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}
      ]
    ]

  onOkButtonClicked: ->
    @execute new CompleteCardRequest(@props.card)
    @context.hideCommandPanel()

}

module.exports = CompleteCommandPanel
