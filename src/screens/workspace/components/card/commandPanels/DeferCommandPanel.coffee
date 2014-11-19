React              = require 'react'
CardCommandContext = require '../CardCommandContext'
Button             = React.createFactory(require 'common/Button')
{div}              = React.DOM

DeferCommandPanel = React.createClass {

  displayName: 'DeferCommandPanel'

  mixins: [CardCommandContext]

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'defer command'}, [
      'Defer'
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', icon: 'ok', text: 'OK'}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @context.hideCommand}
      ]
    ]

}

module.exports = DeferCommandPanel
