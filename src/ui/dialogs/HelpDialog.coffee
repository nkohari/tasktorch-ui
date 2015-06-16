React          = require 'react'
Analytics      = require 'common/Analytics'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
Dialog         = React.createFactory(require 'ui/common/Dialog')
DialogButtons  = React.createFactory(require 'ui/common/DialogButtons')
{a, p, li, ul} = React.DOM

HelpDialog = React.createClass {

  displayName: 'HelpDialog'

  propTypes:
    closeDialog: PropTypes.func

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Close', onClick: @props.closeDialog}

    Dialog {icon: 'help', title: "Help", className: 'help-dialog', buttons, closeDialog: @props.closeDialog},
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

  showHelp: ->
    @props.closeDialog()
    Analytics.showHelp()

}

module.exports = HelpDialog
