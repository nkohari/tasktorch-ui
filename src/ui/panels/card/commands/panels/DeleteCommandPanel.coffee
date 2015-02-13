React             = require 'react'
Observe           = require 'framework/mixins/Observe'
DeleteCardRequest = require 'requests/DeleteCardRequest'
CardContext       = require 'ui/panels/card/CardContext'
Button            = React.createFactory(require 'ui/common/Button')
{div}             = React.DOM

DeleteCommandPanel = React.createClass {

  displayName: 'DeleteCommandPanel'

  mixins: [CardContext, Observe()]

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'delete command'},
      div {className: 'confirm'},
        'Are you sure you want to send this card to the trash?'
      div {className: 'buttons'},
        Button {icon: 'ok',     text: 'OK',     onClick: @onOkButtonClicked}
        Button {icon: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}

  onOkButtonClicked: ->
    @execute new DeleteCardRequest(@props.card)
    @context.hideCommandPanel()

}

module.exports = DeleteCommandPanel
