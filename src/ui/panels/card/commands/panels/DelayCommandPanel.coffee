React       = require 'react'
Observe     = require 'framework/mixins/Observe'
CardContext = require 'ui/panels/card/CardContext'
Button      = React.createFactory(require 'ui/common/Button')
{div}       = React.DOM

DelayCommandPanel = React.createClass {

  displayName: 'DelayCommandPanel'

  mixins: [CardContext, Observe()]

  render: ->

    div {className: 'defer command'},
      'Dulé'
      div {className: 'buttons'},
        Button {icon: 'ok',     text: 'OK'}
        Button {icon: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}

}

module.exports = DelayCommandPanel
