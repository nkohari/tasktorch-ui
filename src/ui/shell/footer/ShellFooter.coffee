#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
Analytics         = require 'common/Analytics'
PropTypes         = require 'ui/framework/PropTypes'
ShellContext      = require 'ui/framework/mixins/ShellContext'
Frame             = React.createFactory(require 'ui/common/Frame')
BottomLeftCorner  = React.createFactory(require 'ui/shell/footer/BottomLeftCorner')
BottomRightCorner = React.createFactory(require 'ui/shell/footer/BottomRightCorner')
BottomCenter      = React.createFactory(require 'ui/shell/footer/BottomCenter')
#--------------------------------------------------------------------------------
require './ShellFooter.styl'
#--------------------------------------------------------------------------------

ShellFooter = React.createClass {

  displayName: 'ShellFooter'

  mixins: [ShellContext]

  componentDidMount: ->
    Analytics.init(@getCurrentUser(), @getCurrentOrg())

  render: ->

    Frame {className: 'shell-footer'},
      BottomLeftCorner {}
      BottomCenter {}
      BottomRightCorner {}

}

module.exports = ShellFooter
