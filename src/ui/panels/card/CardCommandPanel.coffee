React                = require 'react'
CardCommand          = require 'data/enums/CardCommand'
PropTypes            = require 'ui/framework/PropTypes'
CommandContext       = require 'ui/framework/mixins/CommandContext'
DeferCommandPanel    = React.createFactory(require 'ui/panels/card/commands/panels/DeferCommandPanel')
PassCommandPanel     = React.createFactory(require 'ui/panels/card/commands/panels/PassCommandPanel')
CompleteCommandPanel = React.createFactory(require 'ui/panels/card/commands/panels/CompleteCommandPanel')
DeleteCommandPanel   = React.createFactory(require 'ui/panels/card/commands/panels/DeleteCommandPanel')

CardCommandPanel = React.createClass {

  displayName: 'CardCommandPanel'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  mixins: [CommandContext]

  render: ->

    CommandPanel = @getCommandPanelClass()
    CommandPanel {card: @props.card, stack: @props.stack}

  getCommandPanelClass: ->
    switch @getActiveCommand()
      when CardCommand.Defer    then DeferCommandPanel
      when CardCommand.Pass     then PassCommandPanel
      when CardCommand.Complete then CompleteCommandPanel
      when CardCommand.Delete   then DeleteCommandPanel

}

module.exports = CardCommandPanel
