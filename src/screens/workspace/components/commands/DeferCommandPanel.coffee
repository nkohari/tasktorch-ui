React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

DeferCommandPanel = React.createClass {

  displayName: 'DeferCommandPanel'

  propTypes:
    hideCommand: React.PropTypes.func.isRequired

  render: ->

    div {className: 'defer command'}, [
      'Defer'
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', icon: 'ok', text: 'OK'}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @props.hideCommand}
      ]
    ]

}

module.exports = DeferCommandPanel
