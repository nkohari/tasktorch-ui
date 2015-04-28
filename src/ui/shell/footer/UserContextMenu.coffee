superagent           = require 'superagent'
React                = require 'react'
Router               = require 'react-router'
UserLoggedOutEvent   = require 'events/ui/UserLoggedOutEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{a}                  = React.DOM

UserContextMenu = React.createClass {

  displayName: 'UserContextMenu'

  propTypes:
    hideOverlay: PropTypes.func

  mixins: [Actor, Router.Navigation]

  render: ->

    ContextMenu {position: 'top right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'ChangeMyName'},
        Icon {name: 'user'}
        'Change my name'
      DialogTrigger {name: 'ChangeMyPassword'},
        Icon {name: 'secure'}
        'Change my password'
      ContextMenuSeparator {}
      a {onClick: @logOut},
        Icon {name: 'logout'}
        'Log out'

  logOut: ->
    @publish new UserLoggedOutEvent()
    superagent.post('/api/sessions/logout').end (res) =>
      @transitionTo('login')

}

module.exports = UserContextMenu
