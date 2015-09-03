#--------------------------------------------------------------------------------
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

CompleteButtonCallout = React.createClass {

  displayName: 'CompleteButtonCallout'

  render: ->

    Callout {selector: '.card .commands .button-group.right', position: 'above right'},
      p {},
        "When you're finished with a card and ready to declare victory, you can click the "
        "checkmark here to mark it "
        em {}, "complete"
        ". This sends the card to the "
        em {}, "archive"
        ", where you can find it again later."
      p {},
        "If you decide you don't want a certain card anymore, you can click the trash can "
        "here to delete it forever. You can do that with this example card after we're done "
        "with the walkthrough if you want, but there are plenty more actions under Next Steps to try."

}

module.exports = CompleteButtonCallout
