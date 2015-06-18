#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Frame          = React.createFactory(require 'ui/common/Frame')
TopCenter      = React.createFactory(require 'ui/shell/header/TopCenter')
TopLeftCorner  = React.createFactory(require 'ui/shell/header/TopLeftCorner')
TopRightCorner = React.createFactory(require 'ui/shell/header/TopRightCorner')
#--------------------------------------------------------------------------------
require './ShellHeader.styl'
#--------------------------------------------------------------------------------

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  render: ->

    Frame {className: 'shell-header'},
      TopLeftCorner {}
      TopCenter {}
      TopRightCorner {}

}

module.exports = ShellHeader
