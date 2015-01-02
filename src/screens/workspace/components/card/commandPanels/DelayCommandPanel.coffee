React       = require 'react'
Observe     = require 'mixins/Observe'
CardContext = require '../CardContext'
Button      = React.createFactory(require 'common/Button')
{div}       = React.DOM

DelayCommandPanel = React.createClass {

  displayName: 'DelayCommandPanel'

  mixins: [CardContext, Observe()]

  render: ->

    div {className: 'defer command'}, [
      'Delay'
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', icon: 'ok', text: 'OK'}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommandPanel}
      ]
    ]

}

module.exports = DelayCommandPanel
