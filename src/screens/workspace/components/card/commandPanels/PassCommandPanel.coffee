React                      = require 'react'
Observe                    = require 'mixins/Observe'
PassCardRequest            = require 'requests/PassCardRequest'
CardContext                = require '../CardContext'
Button                     = React.createFactory(require 'common/Button')
MultilineText              = React.createFactory(require 'common/MultilineText')
CommandArgument            = React.createFactory(require './CommandArgument')
RecipientSelector          = React.createFactory(require '../RecipientSelector')
{div, em, label, textarea} = React.DOM

PassCommandPanel = React.createClass {

  displayName: 'PassCommandPanel'

  mixins: [CardContext, Observe()]

  getInitialState: ->
    {recipient: undefined, message: undefined}

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->
    div {className: 'handoff command'}, [
      CommandArgument {key: 'recipient', label: 'Pass card to'}, [
        RecipientSelector {key: 'selector', ref: 'selector', placeholder: 'Choose a user or team', onChange: @onRecipientChanged}
      ]
      CommandArgument {key: 'message', label: 'Message', hint: '(optional)'}, [
        MultilineText {key: 'message', className: 'message', onChange: @onMessageChanged}
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}
      ]
    ]

  onRecipientChanged: (recipient) ->
    @setState {recipient}

  onMessageChanged: (message) ->
    @setState {message}

  onOkButtonClicked: ->
    @execute new PassCardRequest(@props.card, @state.recipient, @state.message)
    @context.hideCommandPanel()

}

module.exports = PassCommandPanel
