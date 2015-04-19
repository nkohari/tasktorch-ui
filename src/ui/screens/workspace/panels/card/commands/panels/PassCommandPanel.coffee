React                    = require 'react'
UserPassedCardEvent      = require 'events/ui/UserPassedCardEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
CommandContext           = require 'ui/framework/mixins/CommandContext'
Button                   = React.createFactory(require 'ui/common/Button')
Field                    = React.createFactory(require 'ui/common/Field')
EditableTextArea         = React.createFactory(require 'ui/common/EditableTextArea')
SuggestingSelector       = React.createFactory(require 'ui/common/SuggestingSelector')
UserOrTeamSelectorOption = React.createFactory(require 'ui/common/UserOrTeamSelectorOption')
{div}                    = React.DOM

PassCommandPanel = React.createClass {

  displayName: 'PassCommandPanel'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  getInitialState: ->
    {recipient: undefined, message: undefined}

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->

    div {className: 'handoff command'},
      Field {label: 'Recipient'},
        SuggestingSelector {
          ref:         'selector'
          option:      UserOrTeamSelectorOption
          placeholder: 'Choose a user or team',
          suggest:     ['user', 'team']
          onChange:    @onRecipientChanged
        }
      div {className: 'buttons'},
        Button {text: 'Pass', className: 'default', onClick: @passCard}
        Button {text: 'Cancel', onClick: @hideCommand}

  onRecipientChanged: (item, type) ->
    @setState {recipient: {item, type}}

  onMessageChanged: (message) ->
    @setState {message}

  passCard: ->
    @publish new UserPassedCardEvent(@props.card.id, @state.recipient, @state.message)
    @hideCommand()

}

module.exports = PassCommandPanel
