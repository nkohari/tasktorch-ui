_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Frame          = React.createFactory(require 'ui/common/Frame')
OrgContextMenu = React.createFactory(require 'ui/shell/header/OrgContextMenu')

TopRightCorner = React.createClass {

  displayName: 'TopRightCorner'

  render: ->

    Frame {className: 'top-right'},
      OrgContextMenu {}

}

module.exports = TopRightCorner
