_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
Frame             = React.createFactory(require 'ui/common/Frame')
BottomLeftCorner  = React.createFactory(require 'ui/shell/footer/BottomLeftCorner')
BottomRightCorner = React.createFactory(require 'ui/shell/footer/BottomRightCorner')
BottomCenter      = React.createFactory(require 'ui/shell/footer/BottomCenter')

ShellFooter = React.createClass {

  displayName: 'ShellFooter'

  render: ->

    Frame {className: 'shell-footer'},
      BottomLeftCorner {}
      BottomCenter {}
      BottomRightCorner {}

}

module.exports = ShellFooter
