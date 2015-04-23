_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
ShellContext  = require 'ui/framework/mixins/ShellContext'
Avatar        = React.createFactory(require 'ui/common/Avatar')
DialogTrigger = React.createFactory(require 'ui/common/DialogTrigger')
Frame         = React.createFactory(require 'ui/common/Frame')
Icon          = React.createFactory(require 'ui/common/Icon')

BottomRightCorner = React.createClass {

  displayName: 'BottomRightCorner'

  mixins: [ShellContext]

  render: ->

    Frame {className: 'bottom-right'},
      DialogTrigger {name: 'UserSettings'},
        Icon {name: 'settings'}
      DialogTrigger {name: 'LogOut'},
        Icon {name: 'logout'}
      Avatar {user: @getCurrentUser()}

}

module.exports = BottomRightCorner
