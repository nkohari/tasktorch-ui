React                      = require 'react'
Observe                    = require 'mixins/Observe'
HandOffCardRequest         = require 'requests/HandOffCardRequest'
CardCommandContext         = require '../CardCommandContext'
Button                     = React.createFactory(require 'common/Button')
MultilineText              = React.createFactory(require 'common/MultilineText')
CommandArgument            = React.createFactory(require './CommandArgument')
RecipientSelector          = React.createFactory(require '../RecipientSelector')
{div, em, label, textarea} = React.DOM

HandOffCommandPanel = React.createClass {

  displayName: 'HandOffCommandPanel'

  mixins: [CardCommandContext, Observe()]

  getInitialState: ->
    {recipient: undefined, message: undefined}

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->
    div {className: 'handoff command'}, [
      CommandArgument {key: 'recipient', label: 'Recipient'}, [
        RecipientSelector {key: 'selector', ref: 'selector', placeholder: 'Choose a user or team', onChange: @onRecipientChanged}
      ]
      CommandArgument {key: 'message', label: 'Message', hint: '(optional)'}, [
        MultilineText {key: 'message', className: 'message', onChange: @onMessageChanged}
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', text: 'Cancel', onClick: @context.hideCommand}
      ]
    ]

  onRecipientChanged: (recipient) ->
    @setState {recipient}

  onMessageChanged: (message) ->
    @setState {message}

  onOkButtonClicked: ->
    @execute new HandOffCardRequest(@props.card, @state.recipient, @state.message)
    @context.hideCommand()

}

module.exports = HandOffCommandPanel
