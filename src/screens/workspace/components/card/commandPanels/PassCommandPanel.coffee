React                      = require 'react'
Observe                    = require 'mixins/Observe'
PassCardRequest            = require 'requests/PassCardRequest'
CardContext                = require '../CardContext'
Button                     = React.createFactory(require 'common/Button')
MultilineText              = React.createFactory(require 'common/MultilineText')
SuggestingSelector         = React.createFactory(require 'common/SuggestingSelector')
UserOrTeamSelectorOption   = React.createFactory(require 'common/UserOrTeamSelectorOption')
CommandArgument            = React.createFactory(require './CommandArgument')
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
        SuggestingSelector {
          key:         'selector'
          ref:         'selector'
          option:      UserOrTeamSelectorOption
          placeholder: 'Choose a user or team',
          suggest:     ['user', 'team']
          onChange:    @onRecipientChanged
        }
      ]
      CommandArgument {key: 'message', label: 'Message', hint: '(optional)'}, [
        MultilineText {key: 'message', className: 'message', onChange: @onMessageChanged}
      ]
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {key: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}
      ]
    ]

  onRecipientChanged: (item, type) ->
    @setState {recipient: {item, type}}

  onMessageChanged: (message) ->
    @setState {message}

  onOkButtonClicked: ->
    @execute new PassCardRequest(@props.card, @state.recipient, @state.message)
    @context.hideCommandPanel()

}

module.exports = PassCommandPanel
