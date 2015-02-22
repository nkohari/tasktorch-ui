React       = require 'react'
Observe     = require 'framework/mixins/Observe'
CardContext = require 'ui/panels/card/CardContext'
Button      = React.createFactory(require 'ui/common/Button')
{div}       = React.DOM

DeferCommandPanel = React.createClass {

  displayName: 'DeferCommandPanel'

  mixins: [CardContext, Observe()]

  render: ->

    div {className: 'defer command'},
      'Not yet implemented'
      div {className: 'buttons'},
        Button {text: 'Defer'}
        Button {text: 'Cancel', onClick: @context.hideCommandPanel}

}

module.exports = DeferCommandPanel
