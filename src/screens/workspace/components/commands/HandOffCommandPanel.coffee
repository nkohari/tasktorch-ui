React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

HandOffCommandPanel = React.createClass {

  displayName: 'HandOffCommandPanel'

  propTypes:
    hideCommandPanel: React.PropTypes.func.isRequired

  render: ->
    div {className: 'handoff command'}, [
      'Handoff'
      div {key: 'buttons', className: 'buttons'}, [
        Button {key: 'ok', icon: 'ok', text: 'OK'}
        Button {key: 'cancel', icon: 'cancel', text: 'Cancel', onClick: @props.hideCommandPanel}
      ]
    ]

}

module.exports = HandOffCommandPanel
