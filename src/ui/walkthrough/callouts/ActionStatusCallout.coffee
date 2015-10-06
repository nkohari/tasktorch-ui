#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

ActionStatusCallout = React.createClass {

  displayName: 'ActionStatusCallout'

  render: ->

    Callout {selector: '.card-action', position: 'below right'},
      p {},
        "Every action has a "
        em {}, "status"
        ", which lets everyone see if it's not started, in progress, or complete. "
        "You already signed up for TaskTorch and logged in, so I marked these actions as complete for you. Congratulations!"
      p {},
        "When you change the status of actions, your card will move on the Big Picture "
        "screen, letting people know what's going on. Since you're done with all the actions in the Setup stage, "
        "your card would be in the Learn stage. You don't need to worry about that "
        "all the time, though. Just keep marking actions in progress and complete!"

}

module.exports = ActionStatusCallout
