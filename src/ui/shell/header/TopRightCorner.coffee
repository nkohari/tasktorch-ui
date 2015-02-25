_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
Avatar          = React.createFactory(require 'ui/common/Avatar')
DialogTrigger   = React.createFactory(require 'ui/common/DialogTrigger')
Frame           = React.createFactory(require 'ui/common/Frame')
Icon            = React.createFactory(require 'ui/common/Icon')
UserPrefsDialog = React.createFactory(require 'ui/dialogs/UserPrefsDialog')
LogOutDialog    = React.createFactory(require 'ui/dialogs/LogOutDialog')

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  propTypes:
    currentUser: PropTypes.User

  render: ->

    prefsDialog = UserPrefsDialog {}
    logoutDialog = LogOutDialog {}

    Frame {className: 'top-right'},
      DialogTrigger {dialog: prefsDialog},
        Icon {name: 'settings'}
      DialogTrigger {dialog: logoutDialog},
        Icon {name: 'logout'}
      Avatar {user: @props.currentUser}

}

module.exports = TopRightCorner
