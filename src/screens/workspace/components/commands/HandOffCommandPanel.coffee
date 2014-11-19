React                      = require 'react'
Button                     = React.createFactory(require 'common/Button')
MultilineText              = React.createFactory(require 'common/MultilineText')
CommandArgument            = React.createFactory(require './CommandArgument')
RecipientSelector          = React.createFactory(require '../RecipientSelector')
{div, em, label, textarea} = React.DOM

HandOffCommandPanel = React.createClass {

  displayName: 'HandOffCommandPanel'

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->
    div {className: 'handoff command'}, [
      CommandArgument {key: 'recipient', label: 'Recipient'}, [
        RecipientSelector {key: 'selector', placeholder: 'Choose a user or team'}
      ]
      CommandArgument {key: 'message', label: 'Message', hint: '(optional)'}, [
        MultilineText {key: 'message', className: 'message'}
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', text: 'OK'}
        Button {key: 'cancel', text: 'Cancel', onClick: @props.hideCommand}
      ]
    ]

}

module.exports = HandOffCommandPanel
