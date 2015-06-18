#--------------------------------------------------------------------------------
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CommandContext     = require 'ui/framework/mixins/CommandContext'
Button             = React.createFactory(require 'ui/common/Button')
CardCommandOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandOverlay')
{div}              = React.DOM
#--------------------------------------------------------------------------------

DeferCommandOverlay = React.createClass {

  displayName: 'DeferCommandOverlay'

  propTypes:
    card: PropTypes.Card

  mixins: [CommandContext]

  render: ->

    buttons = div {className: 'buttons'},
      Button {text: 'Cancel', onClick: @hideCommand}      

    CardCommandOverlay {className: 'defer', buttons},
      'Not yet implemented'

}

module.exports = DeferCommandOverlay
