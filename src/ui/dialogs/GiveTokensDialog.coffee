#--------------------------------------------------------------------------------
_                      = require 'lodash'
React                  = require 'react'
UserCreatedTokensEvent = require 'events/ui/UserCreatedTokensEvent'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
CachedState            = require 'ui/framework/mixins/CachedState'
ShellContext           = require 'ui/framework/mixins/ShellContext'
Button                 = React.createFactory(require 'ui/common/Button')
Dialog                 = React.createFactory(require 'ui/common/Dialog')
DialogButtons          = React.createFactory(require 'ui/common/DialogButtons')
TokenEditor            = React.createFactory(require 'ui/common/TokenEditor')
Field                  = React.createFactory(require 'ui/common/Field')
#--------------------------------------------------------------------------------

GiveTokensDialog = React.createClass {

  displayName: 'GiveTokensDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: ->
    {tokens: []}

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Give Tokens', onClick: @sendTokens, disabled: !@isValid()}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'token', title: "Give beta tokens", buttons, className: 'give-tokens-dialog', closeDialog: @props.closeDialog},
      Field {label: 'Who would you like to give beta tokens to?'},
        TokenEditor {value: @state.tokens, @onChange}

  onChange: (tokens) ->
    @setState {tokens}

  isValid: ->
    @state.tokens.length > 0

  sendTokens: ->
    @publish new UserCreatedTokensEvent(@state.tokens)
    @props.closeDialog()

}

module.exports = GiveTokensDialog
