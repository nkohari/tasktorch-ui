#--------------------------------------------------------------------------------
React               = require 'react'
UserPassedCardEvent = require 'events/ui/UserPassedCardEvent'
PropTypes           = require 'ui/framework/PropTypes'
Actor               = require 'ui/framework/mixins/Actor'
CommandContext      = require 'ui/framework/mixins/CommandContext'
Button              = React.createFactory(require 'ui/common/Button')
Field               = React.createFactory(require 'ui/common/Field')
Icon                = React.createFactory(require 'ui/common/Icon')
SuggestingSelector  = React.createFactory(require 'ui/common/SuggestingSelector')
UserOrTeamOption    = React.createFactory(require 'ui/options/UserOrTeamOption')
CardCommandOverlay  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}               = React.DOM
#--------------------------------------------------------------------------------

PassCommandOverlay = React.createClass {

  displayName: 'PassCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [Actor, CommandContext]

  getInitialState: ->
    {recipient: undefined}

  componentDidMount: ->
    @refs.selector.getDOMNode().focus()

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Pass Card', className: 'default', disabled: !@isValid(), onClick: @passCard}
      Button {text: 'Cancel', onClick: @hideCommand}

    CardCommandOverlay {className: 'pass', buttons},
      Field {label: 'Who should be responsible for this card?', hint: 'pass-card'},
        SuggestingSelector {
          ref:         'selector'
          option:      UserOrTeamOption
          placeholder: 'Choose a user or team',
          suggest:     ['user', 'team']
          onChange:    @onRecipientChanged
        }

  isValid: ->
    @state.recipient?

  onRecipientChanged: (item, type) ->
    @setState {recipient: {item, type}}

  passCard: ->
    @publish new UserPassedCardEvent(@props.card.id, @state.recipient, @state.message)
    @hideCommand()

}

module.exports = PassCommandOverlay
