React                      = require 'react'
Observe                    = require 'framework/mixins/Observe'
PassCardRequest            = require 'requests/PassCardRequest'
CardContext                = require 'ui/panels/card/CardContext'
Button                     = React.createFactory(require 'ui/common/Button')
EditableTextBlock          = React.createFactory(require 'ui/common/EditableTextBlock')
SuggestingSelector         = React.createFactory(require 'ui/common/SuggestingSelector')
UserOrTeamSelectorOption   = React.createFactory(require 'ui/common/UserOrTeamSelectorOption')
CommandArgument            = React.createFactory(require 'ui/panels/card/commands/panels/CommandArgument')
{div, em, label, textarea} = React.DOM

PassCommandPanel = React.createClass {

  displayName: 'PassCommandPanel'

  mixins: [CardContext, Observe()]

  getInitialState: ->
    {recipient: undefined, message: undefined}

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->

    div {className: 'handoff command'},
      CommandArgument {label: 'Pass card to'},
        SuggestingSelector {
          ref:         'selector'
          option:      UserOrTeamSelectorOption
          placeholder: 'Choose a user or team',
          suggest:     ['user', 'team']
          onChange:    @onRecipientChanged
        }
      CommandArgument {label: 'Message', hint: '(optional)'},
        EditableTextBlock {className: 'message', onChange: @onMessageChanged}
      div {className: 'buttons'},
        Button {text: 'Pass', className: 'default', onClick: @onOkButtonClicked}
        Button {text: 'Cancel', onClick: @context.hideCommandPanel}

  onRecipientChanged: (item, type) ->
    @setState {recipient: {item, type}}

  onMessageChanged: (message) ->
    @setState {message}

  onOkButtonClicked: ->
    @execute new PassCardRequest(@props.card, @state.recipient, @state.message)
    @context.hideCommandPanel()

}

module.exports = PassCommandPanel
