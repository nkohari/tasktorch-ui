React                = require 'react/addons'
PropTypes            = require 'ui/framework/PropTypes'
CommandContextMaster = require 'ui/framework/mixins/CommandContextMaster'
Button               = React.createFactory(require 'ui/common/Button')
CardCommandBar       = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandBar')
CardCommandPanel     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/CardCommandPanel')
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
{div}                = React.DOM

CardFooter = React.createClass {

  displayName: 'CardFooter'

  propTypes:
    card:        PropTypes.Card
    kind:        PropTypes.Kind
    stack:       PropTypes.Stack
    currentUser: PropTypes.User

  mixins: [CommandContextMaster]

  render: ->

    div {className: 'card-footer'},
      CSSTransitionGroup {className: 'command-placeholder', component: 'div', transitionName: 'slide'},
        CardCommandPanel {card: @props.card, stack: @props.stack} if @hasActiveCommand()
      CardCommandBar {card: @props.card, stack: @props.stack}

}

module.exports = CardFooter
