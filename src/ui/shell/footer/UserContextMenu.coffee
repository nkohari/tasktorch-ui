#--------------------------------------------------------------------------------
superagent           = require 'superagent'
React                = require 'react'
Router               = require 'react-router'
GrantType            = require 'data/enums/GrantType'
Request              = require 'data/framework/Request'
UserLoggedOutEvent   = require 'events/ui/UserLoggedOutEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM
#--------------------------------------------------------------------------------

UserContextMenu = React.createClass {

  displayName: 'UserContextMenu'

  propTypes:
    user:        PropTypes.User
    hideOverlay: PropTypes.func

  mixins: [Actor, Router.Navigation]

  render: ->

    commonItems = [
      DialogTrigger {name: 'ChangeMyName'},
        Icon {name: 'user'}
        'Change my name'
      DialogTrigger {name: 'ChangeMyEmail'},
        Icon {name: 'email'}
        'Change my email'
      DialogTrigger {name: 'ChangeMyPassword'},
        Icon {name: 'secure'}
        'Change my password'
      ContextMenuSeparator {}
      a {onClick: @logOut},
        Icon {name: 'logout'}
        'Log out'
    ]

    giveTokensItems = [
      DialogTrigger {name: 'GiveTokens'},
        Icon {name: 'token'}
        'Give beta tokens'
      ContextMenuSeparator {}
    ]

    ContextMenu {position: 'top right', hideOverlay: @props.hideOverlay},
      giveTokensItems if _.contains(@props.user?.grants, GrantType.GiveTokens)
      commonItems

  logOut: ->
    @publish new UserLoggedOutEvent()
    superagent
    .post(Request.urlFor('/sessions/logout'))
    .withCredentials()
    .end (err, res) =>
      @transitionTo('login')

}

module.exports = UserContextMenu
