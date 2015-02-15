React               = require 'react'
Observe             = require 'framework/mixins/Observe'
CompleteCardRequest = require 'requests/CompleteCardRequest'
CardContext         = require 'ui/panels/card/CardContext'
Button              = React.createFactory(require 'ui/common/Button')
{div}               = React.DOM

CompleteCommandPanel = React.createClass {

  displayName: 'CompleteCommandPanel'

  mixins: [CardContext, Observe()]

  render: ->

    div {className: 'complete command'},
      div {className: 'confirm'},
        'Are you sure you want to complete this card?'
      div {className: 'buttons'},
        Button {text: 'Complete Card', className: 'default', onClick: @onOkButtonClicked}
        Button {text: 'Cancel', onClick: @context.hideCommandPanel}

  onOkButtonClicked: ->
    @execute new CompleteCardRequest(@props.card)
    @context.hideCommandPanel()

}

module.exports = CompleteCommandPanel
