#--------------------------------------------------------------------------------
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------
require './InboxCallout.styl'
#--------------------------------------------------------------------------------

InboxCallout = React.createClass {

  displayName: 'InboxCallout'

  render: ->

    Callout {className: 'inbox-callout', selector: '.my-work .drawer-item', position: 'top right'},
      p {},
        "When you pass a card to someone, it will go to their "
        em {}, "inbox"
        ". From there, they can choose to "
        em {}, "accept"
        " it, adding it to their queue, or they can pass it along to someone else. They can "
        "also pass it back to you if they don't understand or need more information."
      p {},
        "Likewise, when someone passes you a card, it'll be delivered to your inbox. Your inbox is "
        "empty right now, but you can start exchanging cards once you invite others to your organization."

}

module.exports = InboxCallout
