React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
CommandContext = require 'ui/framework/mixins/CommandContext'
Button         = React.createFactory(require 'ui/common/Button')
{div}          = React.DOM

DeferCommandPanel = React.createClass {

  displayName: 'DeferCommandPanel'

  propTypes:
    card: PropTypes.Card

  mixins: [CommandContext]

  render: ->

    div {className: 'defer command'},
      'Not yet implemented'
      div {className: 'buttons'},
        Button {text: 'Defer'}
        Button {text: 'Cancel', onClick: @hideCommand}

}

module.exports = DeferCommandPanel
