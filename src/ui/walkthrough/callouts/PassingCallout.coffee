#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

PassingCallout = React.createClass {

  displayName: 'PassingCallout'

  render: ->

    Callout {selector: '.card .commands .command-toggle-pass', position: 'above left'},
      p {},
        "This is my favorite part! When you're finished with what you need to do, "
        "you click here, and pass the card to the next person who should be responsible for it. "
        "Think of it like handing off the baton in a race."

}

module.exports = PassingCallout
