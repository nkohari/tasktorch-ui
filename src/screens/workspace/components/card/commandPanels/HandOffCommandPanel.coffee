React                      = require 'react'
CardCommandContext         = require '../CardCommandContext'
Button                     = React.createFactory(require 'common/Button')
MultilineText              = React.createFactory(require 'common/MultilineText')
CommandArgument            = React.createFactory(require './CommandArgument')
RecipientSelector          = React.createFactory(require '../RecipientSelector')
{div, em, label, textarea} = React.DOM

HandOffCommandPanel = React.createClass {

  displayName: 'HandOffCommandPanel'

  mixins: [CardCommandContext]

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->
    div {className: 'handoff command'}, [
      CommandArgument {key: 'recipient', label: 'Recipient'}, [
        RecipientSelector {key: 'selector', ref: 'selector', placeholder: 'Choose a user or team'}
      ]
      CommandArgument {key: 'message', label: 'Message', hint: '(optional)'}, [
        MultilineText {key: 'message', className: 'message'}
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', text: 'OK'}
        Button {key: 'cancel', text: 'Cancel', onClick: @context.hideCommand}
      ]
    ]

}

module.exports = HandOffCommandPanel
