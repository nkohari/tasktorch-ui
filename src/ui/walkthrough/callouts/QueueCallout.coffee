#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{em, p}   = React.DOM
#--------------------------------------------------------------------------------

QueueCallout = React.createClass {

  displayName: 'QueueCallout'

  render: ->

    Callout {selector: '.stack.panel', position: 'top right'},
      p {},
        "Right now, the card is in your "
        em {}, "priorities list"
        ", which means that you've taken responsibility for it. This is your personal "
        "to-do list in TaskTorch."
      p {},
        "No one else is allowed to add anything to your priorities list. "
        "It's yours and yours alone! When you accept responsibility for cards, they're added "
        "to your priorities, and you can drag them around to reorganize your priorities."
      p {},
        "By keeping your priorities up to date, you can be sure your teammates always know "
        "what you're working on without asking you for a status update."

}

module.exports = QueueCallout
