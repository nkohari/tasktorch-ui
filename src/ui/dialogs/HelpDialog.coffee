#--------------------------------------------------------------------------------
React          = require 'react'
Analytics      = require 'common/Analytics'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
Dialog         = React.createFactory(require 'ui/common/Dialog')
DialogFooter   = React.createFactory(require 'ui/common/DialogFooter')
{a, p, li, ul} = React.DOM
#--------------------------------------------------------------------------------
require './HelpDialog.styl'
#--------------------------------------------------------------------------------

HelpDialog = React.createClass {

  displayName: 'HelpDialog'

  propTypes:
    closeDialog: PropTypes.func

  render: ->

    footer = DialogFooter {
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'help', title: "Help", className: 'help-dialog', footer, closeDialog: @props.closeDialog},
      p {},
        "We've created the "
        a {href: "http://support.tasktorch.com/", target: "_blank"}, "TaskTorch Guide"
        " to help you get acquainted with the product."
      p {},
        "Here are a few popular articles from the guide that might be helpful:"
      ul {},
        li {},
          a {href: "http://support.tasktorch.com/articles/tour.html", target: "_blank"},
            "Tour"
        li {},
          a {href: "http://support.tasktorch.com/articles/cards.html", target: "_blank"},
            "What are Cards?"
        li {},
          a {href: "http://support.tasktorch.com/articles/actions.html", target: "_blank"},
            "What are Actions?"
      p {},
        "If you don't see what you need, or if you just want to give us some feedback, you can "
        a {onClick: @showHelp}, "start a support conversation"
        "."
      p {className: 'warning'},
        "Some of our users have reported that content blockers (eg. uBlock) interfere with "
        "our help system. If you are using a content blocker, please disable it for this site!"

  showHelp: ->
    @props.closeDialog()
    Analytics.showHelp()

}

module.exports = HelpDialog
